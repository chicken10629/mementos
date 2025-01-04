class Public::FavoritesController < ApplicationController
  
  #あるユーザーがいいねした一覧を表示したい。とりあえずcurrent_userのみでやる
  #has_manyを設定しているとjoinを使えるらしい。
  #joinは二つ以上のテーブルを関連付け、一度にデータを取得
  #
  def index
    @favorites = current_user.favorites.includes(:post)
  end

  def create
    #ビュー側でインスタンス変数使わなければローカルでよさげ？
    #拾ってくるidはネストしてる親のid
    #pathにpost_idをセットし、コントローラーに送る
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to post_path(post), notice: "いいねしました。"
  end

  def destroy
    #ネストしているものは基本的に親のデータを取得し、各idをセットしてからデータをいじる。
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    if request.referer.include?("posts")#リクエスト元のURLにpostsが含まれているか？
      redirect_to post_path(post), notice: "いいねを解除しました。"
    else
      redirect_to my_favorites_path, notice: "いいねを解除しました。"
    end
  end
  
end
