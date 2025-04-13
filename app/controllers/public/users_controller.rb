class Public::UsersController < ApplicationController
  def my_page
    @user = User.find(current_user.id)
    @posts = @user.posts.order(created_at: :desc) #current_userに紐づく投稿データを最新順に表示
    @posts = @posts.page(params[:page]).per(12)
  end
  

  def public_status
    @user = current_user #これ設定しないとis_publicがnilになってしまう
    @user.update(is_public: !@user.is_public) #現在のis_publicの反対の状態にする
    redirect_to my_page_path, notice: '公開状態を変更しました。'
  end

  def my_page_edit
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound 
      redirect_to users_path, alert: '他のユーザーのプロフィールは編集できません。'
      return #ここで処理終了
    end
    if current_user.id.to_s != params[:id]
      redirect_to users_path, alert: '他のユーザーのプロフィールは編集できません。'
      return
    end
  end

  def index
    @users = User.where(is_active: true)
    @users = @users.page(params[:page]).per(10)
    #倫理削除された物を除く
  end

  def show
    
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound #カラムが存在しない場合の処理
      redirect_to users_path, alert: 'このユーザーは存在しないか、既にアカウントを削除しています。'
      return #ここで処理終了
    end
    #current_userである場合my_pageへ飛ばす
    if @user == current_user
      redirect_to my_page_path and return # and returnで処理が終了する
    end
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(12)
    #投稿を最新順に表示
  end

  def my_page_update
    @user = User.find(params[:id]) #バリデーションエラー表示のため、ローカルではなくインスタンス変数で
    if @user.update(user_params)
      redirect_to my_page_path, notice: 'プロフィールを更新しました。' #パス名を指定
    else
      render :my_page_edit, alert: 'ユーザー情報の編集に失敗しました。' #こっちはアクション名
    end
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.is_active = false
    if @user.save
      redirect_to top_path, notice: 'アカウントを削除しました。'
    else
      redirect_to my_page_path, alert: 'アカウントの削除に失敗しました。'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image) #更新したいカラム名の使用許可
  end
  
end
