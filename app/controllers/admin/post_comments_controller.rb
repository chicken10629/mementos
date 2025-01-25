class Admin::PostCommentsController < ApplicationController
  #指定のidのコメントを削除されました。に変更したい。
  def update
    @post_comment = PostComment.find(params[:id])
    @post = Post.find(params[:post_id])
    @post_comment.comment = "このコメントは削除されました。"
    if @post_comment.save
      redirect_to admin_post_path(@post.id), notice: 'コメントが削除されました。'
    else
      redirect_to admin_post_path(@post.id), alert: 'コメントの削除に失敗しました。'
    end
  end

end
