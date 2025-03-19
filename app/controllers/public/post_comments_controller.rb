class Public::PostCommentsController < ApplicationController
  def create
    #投稿データを取得　post_idを指定してるのはネストしてるから？
    @post = Post.find(params[:post_id])
    #中身を初期化してから、コメント投稿ユーザーとコメント対象のidをセット
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.post_id = @post.id
    if @post_comment.save
      redirect_to post_path(@post) , notice: "コメントを投稿しました。"
    else
      redirect_to post_path(@post) , alert: "100文字以内で何かコメントしてください。"
    end
  end

  def delete
    @post_comment = PostComment.find(params[:id])
    @post = Post.find(params[:post_id])
    @post_comment.comment = "このコメントはユーザーによって削除されました。" 
    if @post_comment.save
      redirect_to post_path(@post.id), notice: 'コメントを削除しました。'
    else
      redirect_to post_path(@post.id), alert: 'コメントの削除に失敗しました。'
    end
  end


  private
  
  def post_comment_params
    params.require(:post_comment).permit(:user_id, :post_id, :comment)
  end
end
