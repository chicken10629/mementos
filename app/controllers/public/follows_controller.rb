class Public::FollowsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @followed_users = Follow.where(follower_id: @user.id).pluck(:followed_id)#pluckでfollowed_idのみ取得
    @followed_users = User.where(id: @follwed_users) #userモデルに記述したメソッド。followしたユーザー取得
  end

  def create   
    other_user = User.find_by(id: params[:user_id])#ネストされたidであるため、params[:id]⇒params[:user_id]と指定
    current_user.follow(other_user) #userモデル側にfollow、unfollowを定義する。親となるモデルが、実際の操作を行うためらしい。followモデルはあくまで中間テーブルのモデル。
    redirect_to user_path(other_user), notice: 'このユーザーをフォローしました。'
  end

  def destroy
    other_user = User.find_by(id: params[:user_id])#モデル側ではparamsを使えないらしい。
    current_user.unfollow(other_user)
    redirect_to user_path(other_user), notice: 'このユーザーのフォローを解除しました。'
  end

end
