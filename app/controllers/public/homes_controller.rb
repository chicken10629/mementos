class Public::HomesController < ApplicationController
  def top
    @posts = Post.order(created_at: :desc).limit(5)
  end
end
