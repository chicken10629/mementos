class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followed, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
# t.referencesは外部キーを示すためのカラム。follower_idとfollowed_idが生成され、これらがusersテーブルのidを参照する
# foreign_key: trueを指定すると、外部キー制約が適用される
# user_idにインデックスが自動で作成されるため、外部キーを利用した検索ができる。