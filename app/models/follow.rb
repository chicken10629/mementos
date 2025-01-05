class Follow < ApplicationRecord
  #followはuserテーブル同士の中間テーブル。
  #実際は中間テーブルではなく、親テーブルが動作するため、具体的なメソッドはuserテーブルに記述
  #belongs_toは関連付けの名前＋_idで検索してくるため、follower_idではなくfollowerで指定する
  #followerというモデルは存在しないため、モデル名を指定する必要アリ
  #belongs_to :followerの時点で外部キーが自動生成されてるが、一応foregin_keyを書いてあげると可読性に繋がって良いらしい
  belongs_to :follower, class_name: "User", foreign_key: "follower_id"
  belongs_to :followed, class_name: "User", foreign_key: "followed_id"
  
  validates :follower_id, uniqueness: {scope: :followed_id}
  #フォローしたユーザーとフォローされたユーザーの組み合わせが唯一であるか？
  
end
