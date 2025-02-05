class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :image
  validates :title, presence: { message: "を入力してください。" }, length: { maximum: 50, message: "は50文字以内で入力してください。"}
  validates :body, presence: { message: "を入力してください。"}, length: { maximum: 500, message: "は500文字以内で入力してください。"}
  #imageのvalidates
  validate :image_content_type, if: :was_attached?

  def image_content_type
    extensions = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:image, "の拡張子はpng、jpg、jpegにして下さい。") unless image.content_type.in?(extensions)
  end

  def was_attached?
    self.image.attached?
  end

  #いいねがついているかのチェック　子ではなく親の方が機能するので、親側にメソッドを作る
  #whereは条件が一致したものを配列でうけとる。
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #検索用。最近のサイトを見るに部分一致だけでよさそうだが、完全一致も追加。
  #Postモデル内で定義するため、Postを省略可。
  def self.search_for(query,method)
    if query.blank?
      return all
    end

    case method
    when "perfect"
      where(title: query)
    when "partial"
      where("title LIKE ?", "%#{query}%")
    else
      all
    end
  end
end