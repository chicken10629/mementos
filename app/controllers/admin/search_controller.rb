class Admin::SearchController < ApplicationController
  def index
    #ransackを使用したuserの検索。検索結果が1行目。2行目で検索結果から重複データをはじく
    @user_q = User.ransack(params[:user_q])
    @users = @user_q.result(distinct: true)

    @post_q = Post.ransack(params[:post_q])
    @posts = @post_q.result(distinct: true)
  end
end
