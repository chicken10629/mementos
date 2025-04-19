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

  #お試しでポストイメージ
  def get_post_image(height,width)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/publicdomainq-0060457lwn.jpg')
      image.attach(io: File.open(file_path), filename: 'publicdomainq-0060457lwn.jpg', content_type: 'image/jpeg')
    end
    #imageがない場合、設定したファイルの位置の画像を呼び出し、保存
    image.representation(resize_to_fill: [height, width,{gravity: "center"}]).processed
    #投稿画像を表示。variantは画像の加工のメソッド。processedはリサイズ処理を適応した状態を結果として返す。
  end
end