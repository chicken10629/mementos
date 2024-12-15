class Public::FollowsController < ApplicationController
  def index
    @followers = current_user.following_users #userモデルに記述したメソッド。followしたユーザー取得
  end

  def create
    @user = User.find(params[:id])
    current_user.follow(@user) #userモデル側にfollow、unfollowを定義する。親となるモデルが、実際の操作を行うためらしい。followモデルはあくまで中間テーブルのモデル。
    redirect_to user_path(@user), notice: 'このユーザーをフォローしました。'
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to user_path(@user), notice: 'このユーザーのフォローを解除しました。'
  end

end
