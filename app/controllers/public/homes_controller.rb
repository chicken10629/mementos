class Public::HomesController < ApplicationController
  def top
    @posts = Post.joins(:user).where(users: {is_active: true, is_public: true}).order(created_at: :desc).limit(5)
    #非公開や倫理削除をしたユーザーの投稿の非表示。
  end
end
