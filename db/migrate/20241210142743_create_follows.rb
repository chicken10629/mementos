class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :follow_user_id
      t.integer :followed_user_id

      t.timestamps
    end
  end
end
