class Admin::PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])#urlからidを取得
  rescue ActiveRecord::RecordNotFound #カラムが存在しない場合
    redirect_to admin_posts_path, alert: 'この投稿は存在しないか、既に削除されています。'
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post.id), notice: "編集しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_posts_path, notice: "削除しました。"
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image) #投稿したいカラム、それを扱うモデルを指定し、扱う許可を与える
    #imagesはpostの配列。params[:post][:images]。
  end
end
