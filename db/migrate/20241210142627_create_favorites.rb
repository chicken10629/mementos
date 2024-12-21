class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true #referencesにuserを指定することでuser_idを生成、foregin_keyに指定することで自動的にuserテーブルと連携する
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
