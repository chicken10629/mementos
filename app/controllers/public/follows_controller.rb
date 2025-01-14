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
    @user = User.find_by(id: params[:user_id])#ネストされたidであるため、params[:id]⇒params[:user_id]と指定
    current_user.follow(@user) #userモデル側にfollow、unfollowを定義する。親となるモデルが、実際の操作を行うためらしい。followモデルはあくまで中間テーブルのモデル。
    render 'replace' #部分テンプレートではなく、jsファイルを指定する。
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    #モデル側ではparamsを使えないらしい。また、params[:id]ではダメだったので、デフォルトの指定が間違っていると思われる。セットするカラムの指定したほうが確実か？
    current_user.unfollow(@user)
    render 'replace'
  end

end
