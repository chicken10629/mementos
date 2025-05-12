class Admin::UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def index
      query = params[:query]
      @users = User.none
      #最後の結果表示でnilになってしまったので初期化
      if query.present?
        @users = User.where( "name LIKE ?", "%#{params[:query]}%" )
      else
        @users = User.all
      end
      #結果の表示
      @users = @users.page(params[:page]).per(10)
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
 
  # transactionで一連のデータ更新を一つの処理とし、全てのSQL実行が成功した際にDBに更新を反映。整合性を保つ目的。
  def destroy
    @user = User.find(params[:id])
    ActiveRecord::Base.transaction do
      @user.posts.destroy_all
      @user.favorites.destroy_all
      @user.following_users.destroy_all
      @user.followers.destroy_all
      @user.destroy
    end
      redirect_to admin_users_path, notice: 'アカウントを削除しました。'
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image) #更新したいカラム名の使用許可
  end
end
