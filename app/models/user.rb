class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_image #アイコン画像のデータ
  #テーブルの関連付け
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follows, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: { message: "を入力してください。" }
  #自分で追加したカラムはバリデーションを設定しないといけないので、nameを追記

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attached(io: file.open(file_path), filename: 'no_image.jpg', content_type: 'image/*')
    end
    #profile_imageがない場合、設定したファイルの位置の画像を呼び出し、保存
    profile_image.variant(resize_to_limit: [100, 100]).processed
    #プロフィール画像を表示。variantは画像の加工のメソッド。processedはリサイズ処理を適応した状態を結果として返す。
  end

end