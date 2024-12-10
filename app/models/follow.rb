class Follow < ApplicationRecord
  belongs_to :user
  
  validates :follow_user_id, uniqueness: {scope: :followed_user_id}
  #フォローしたユーザーとフォローされたユーザーが唯一であるか？
end
