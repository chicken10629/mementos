class Public::FollowsController < ApplicationController
  #フォロー一覧取得アクション
  def followings
    user = User.find(params[:user_id])
    @users = user.following_list
  end
  
  #フォロワー一覧取得アクション
  def followers
    user = User.find(params[:user_id])
    @users = user.followers_list
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
