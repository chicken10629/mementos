class Admin::PostCommentsController < ApplicationController
  #指定のidのコメントを削除されました。に変更したい。
  def update
    @post_comment = PostComment.find(params[:id])
    if @post_comment.update(deleted: true)
      redirect_to admin_post_path(@post.id), notice: 'コメントが削除されました。'
    else
      redirect_to admin_post_path(@post.id), alert: 'コメントの削除に失敗しました。'
    end
  end

end
