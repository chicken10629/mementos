class Admin::PostsController < ApplicationController
  
  def index

    query = params[:query]
    @posts = Post.none
    #最後の結果表示でnilになってしまったので初期化
    if query.present?
      #ラジオボタンの値を受け取り、場合分けをする
      #ラジオボタンを選択しなかったときにboth条件にしているが、一応デフォ設定でbothにしている
      search_in = params[:search_in] || "both"
      #case文　caseで比較対象のオブジェクトを最初に指定し、whenで比較相手を指定
      #つまりユーザー側が指定した検索条件がsearch_inとして受け取っており、
      #それの中身によってうけとったqueryの扱いについて場合分け
      case search_in
      when "title"
        @posts = Post.where( "title LIKE ?", "%#{query}%" )
        #?はプレースホルダ。第二引数で指定した値に置き換えられる　第二引数とtitleを比較する。
        #前後に％がついているため、部分一致
      when "body"
        @posts = Post.where( "body LIKE ?", "%#{query}%" )
      when "both"
        @posts = Post.where( "title LIKE ? OR body LIKE ?", "%#{query}%", "%#{query}%")
      else
        @posts = Post.none #空の配列だとエラーになるのでActiveRecordを使って初期化
      end
    else
      @posts = Post.all
    end
    #結果の表示
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])#urlからidを取得
    @post_comments = PostComment.where(post_id: params[:id])
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
