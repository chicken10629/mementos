class Public::SearchesController < ApplicationController
  #ヘッダーに投稿の部分検索を実装。ユーザーページ限定でユーザー一覧の検索実装も検討
  #検索しやすさを考えるとジャンルを入れた方がよさげか？
 
  #タイトルか本文が部分一致である場合の定義。今回はラジオボタンでの選択方式にする
 # def search
 #   if params[:query].precent?
 #     @results = Post.where("title LIKE ? OR body LIKE", "%#{params[:query]}%", "%#{params[:query]}%")
      #タイトルか本文の部分検索。
 #   else
 #     @results = []
 #   end
 # end

 #ルートではアクション名indexにしたので
  def index
  #入力された文字をURLから受け取る queryとsearch_inが入っているっぽい
    query = params[:query]
    if query.present?
      #ラジオボタンの値を受け取り、場合分けをする
      #ラジオボタンを選択しなかったときにboth条件にしているが、一応デフォ設定でbothにしている
      search_in = params[:search_in] || "both"
      #case文　caseで比較対象のオブジェクトを最初に指定し、whenで比較相手を指定
      case search_in
      when "title"
        @results = Post.where( "title LIKE ?", "%#{query}%" )
        #?はプレースホルダ。第二引数で指定した値に置き換えられる　第二引数とtitleを比較する。
        #前後に％がついているため、部分一致
      when "body"
        @results = Post.where( "body LIKE ?", "%#{query}%" )
      else
        @results = Post.where( "title LIKE ? OR body LIKE ?", "%#{query}%", "%#{query}%")
      end
    else
      results = []
    end
  end
end
