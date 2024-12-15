class Follow < ApplicationRecord
  #followはuserテーブル同士の中間テーブル。
  #実際は中間テーブルではなく、親テーブルが動作するため、具体的なメソッドはuserテーブルに記述
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, uniqueness: {scope: :followed_id}
  #フォローしたユーザーとフォローされたユーザーの組み合わせが唯一であるか？

  
end
