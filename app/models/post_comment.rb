class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment, presence:{message: "を入力してください。"} , length: {maximum: 100, message: "は100文字以内で入力してください。"}
end
