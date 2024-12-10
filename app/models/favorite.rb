class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: {scope: :post_id}
  #ユーザーidと投稿idのペアが唯一であるかチェック
end
