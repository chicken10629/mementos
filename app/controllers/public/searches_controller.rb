class Public::SearchesController < ApplicationController
  def index
  #入力された文字をURLから受け取る query,model,methodが入っている。
  #queryとmethodで検索、modelでユーザー投稿どっちを検索するか選択
  #search_forは自分で定義。それぞれのモデル側に作っておく。
    @query = params[:query]
    @model = params[:model]
    @method = params[:method]

    if @model == 'user'
      @results = User.search_for(@query, @method).page(params[:page]).per(12)
    elsif @model == 'post'
      @results = Post.search_for(@query, @method).page(params[:page]).per(12)
    end
    #何も入力しないときは全件表示。最近のサイトはこれが多いため。
    if @query.blank?
      @results = @results.all.page(params[:page]).per(12)
    end
  end
end
