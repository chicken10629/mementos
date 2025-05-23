class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    #倫理削除したユーザーや非公開ユーザーの投稿を除いて表示
    @posts = Post.joins(:user).where(users: {is_active: true, is_public: true})
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @post = Post.find(params[:id])#urlからidを取得
<<<<<<< HEAD
=======
  
>>>>>>> 15456a0 ([fix]壊れたgitの復旧と非公開ユーザーの投稿の閲覧制限)
    #コメント投稿フォーム
    @post_comment = PostComment.new
    #コメントの取得
    @post_comments = PostComment.where(post_id: params[:id])
  rescue ActiveRecord::RecordNotFound #カラムが存在しない場合
    redirect_to posts_path, alert: 'この投稿は存在しないか、既に削除されています。'
  end

  def create
    @post = Post.new(post_params)
    #ログインユーザーの投稿id
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿しました。" #パス名を指定。showなのでidも欲しい
    else
      render 'new'
    end
  end

  def edit
    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to posts_path, alert: "この投稿は存在しないか、既に削除されています。"
      return
    end
    if @post.user.nil? || @post.user.id != current_user.id
      redirect_to posts_path, alert: "他のユーザーの投稿は編集できません。"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "編集しました。"
    else
      render :edit #@postに保持されているエラー情報を向こうで表示する
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to my_page_path, notice: "投稿を削除しました。"
    else
      render :edit
    end
  end

  private

  def post_params
    #投稿したいカラム、それを扱うモデルを指定し、扱う許可を与える
    params.require(:post).permit(:title, :body, :image)
    #複数投稿を実装する場合…imagesはpostの配列。params[:post][:images]。
  end

end
