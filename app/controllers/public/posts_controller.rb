class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @posts = Post.joins(:user).where(users: {is_active: true, is_public: true})
  end

  def show
    @post = Post.find(params[:id])#urlからidを取得
    #コメント投稿フォーム
    @post_comment = PostComment.new
    #コメントの取得
    @post_comments = PostComment.where(post_id: params[:id])
  rescue ActiveRecord::RecordNotFound #カラムが存在しない場合
    redirect_to posts_path, alert: 'この投稿は存在しないか、既に削除されています。'
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
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to my_page_path, notice: "投稿を削除しました。"
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image) #投稿したいカラム、それを扱うモデルを指定し、扱う許可を与える
    #imagesはpostの配列。params[:post][:images]。
  end

end
