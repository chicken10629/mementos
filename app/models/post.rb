class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :image
  validates :title, :body, presence: { message: "を入力してください。" }
  #あとでhas_many_attached :imagesに変更

  #いいねがついているかのチェック　子ではなく親の方が機能するので、親側にメソッドを作る
  #whereは条件が一致したものを配列でうけとる。
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end