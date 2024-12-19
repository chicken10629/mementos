class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :index, :show], unless: :admin_controller? #管理者コンを除き、トップページ以外でユーザー認証を要求する。


  private

  def configure_authentication
    if admin_controller? #namespaceがadminかどうかチェック。記述は↓
      authenticate_admin!#adminコンだった場合ログイン認証を求める
    else
      authenticate_user! unless action_is_public? #adminコンでなければトップ画面以外で認証を求める
    end
  end

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

end
