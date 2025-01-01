class Admin::UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    #倫理削除された物も含める
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    #投稿を最新順に表示
  end

  def update
    @user = User.find(params[:id]) #バリデーションエラー表示のため、ローカルではなくインスタンス変数で
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'プロフィールを更新しました。' #パス名を指定
    else
      render :edit, alert: 'ユーザー情報の編集に失敗しました。' #こっちはアクション名
    end
  end

  def destroy
    @user = User.find(current_user.id)
    if @user.destroy
      redirect_to admin_users_path, notice: 'アカウントを削除しました。'
    else
      redirect_to admin_users_path, alert: 'アカウントの削除に失敗しました。'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image) #更新したいカラム名の使用許可
  end
end
