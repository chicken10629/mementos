class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :image
  validates :title, :body, presence: { message: "を入力してください。" }
  #あとでhas_many_attached :imagesに変更
end