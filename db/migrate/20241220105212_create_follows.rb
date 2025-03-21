class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }#テーブル名と異なるカラム名であるため、連携先を個別に指定する
      t.references :followed, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
