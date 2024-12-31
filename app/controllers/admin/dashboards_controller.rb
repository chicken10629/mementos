class Admin::DashboardsController < ApplicationController
  def index
    @today_posts = Post.where(created_at: Time.zone.today.beggining_of_day..Time.zone.today.end_of_day).count

    @total_posts = Post.count

   # Visitモデルに訪問者を記録　アプリケーションコントローラーに訪問カウンターを設置　ゲストユーザーも記録
    @today_visits = Visit.where(created_at: Time.zone.today.beggining_of_day..Time.zone.today.end_of_day).count

    @total_visits = Visit.count

    @guests_visits = Visit.where(user: nil).count

    @active_users = User.where(is_active: true).count
    #倫理削除していないユーザーの累計
  end
end
