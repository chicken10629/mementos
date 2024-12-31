class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :index, :show], unless: :admin_controller? #管理者コンを除き、トップページ以外でユーザー認証を要求する。
  before_action :track_visit

  private

  def configure_authentication
    if admin_controller? #namespaceがadminかどうかチェック。記述は↓
      authenticate_admin!#adminコンだった場合ログイン認証を求める
    else
      authenticate_user! unless action_is_public? #adminコンでなければトップ画面以外で認証を求める
    end
  end

  #管理者コントローラーか確認
  def admin_controller?
    self.class.module_parent_name == 'Admin' 
  end

  def action_is_public?
    controller_name == 'homes' && action_name == 'top'
  end

  #サインインしている、なおかつis_activeがfalseである時、強制的にログアウトさせる
  def check_active_user
    if user_signed_in? && !curent_user.is_active?
      sign_out current_user
      redirect_to new_user_session_path, alert: "あなたのアカウントは既に削除されています。"
    end
  end

  private

  def track_visit
    if !user_signed_in? && session[:guest_visited].nil?
      #ゲストユーザーが初めて訪問したとき、記録をする
      Visit.create(user: nil, visited_at: Time.current)
      session[:guest_visited] = true
      #guest_visitedはセッション変数。ユーザーがサイトを訪問しているとき、一時的に保存される
      #セッション変数がnilの時カウントしし、そのあとtrueにすることで次回以降のカウントを阻止する
    elsif user_signed_in?
      Visit.create(user: current_user, visited_at: Time.current)
    end
  end

end
