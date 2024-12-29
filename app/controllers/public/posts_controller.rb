class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])#urlからidを取得
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿しました。" #パス名を指定。showなのでidも欲しい
    else
      render :new, alert: "投稿に失敗しました。"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "編集しました。"
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image) #投稿したいカラム、それを扱うモデルを指定し、扱う許可を与える
    #imagesはpostの配列。params[:post][:images]。
  end

end
