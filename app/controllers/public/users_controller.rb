class Public::UsersController < ApplicationController
  def mypage
    @user = User.current_user
    @posts = Post.current_user
  end

  def public_status
    

  def edit
  end

  def index
  end

  def show
  end

  def update
  end

  def destroy
  end
  
end
