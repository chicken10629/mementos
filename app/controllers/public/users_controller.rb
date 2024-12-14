class Public::UsersController < ApplicationController
  def my_page
    @user = User.find(current_user.id)
    @posts = @user.posts.order(created_at: :desc) #current_userに紐づく投稿データを最新順に表示
  end

  def public_status
    @user = current_user #これ設定しないとis_publicがnilになってしまう
    @user.update(is_public: !@user.is_public)
    redirect_to my_page_path, notice: '公開状態を変更しました。'
  end

  def my_page_edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def my_page_update
    @user = User.find(params[:id]) #バリデーションエラー表示のため、ローカルではなくインスタンス変数で
    if @user.update(user_params)
      redirect_to my_page_path, notice: 'プロフィールを更新しました。'
    else
      render :my_page_edit, alert: 'ユーザー情報の編集に失敗しました。'
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
