class AddForeignKeyToVisits < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :visits, :users, column: :user_id
  end
end
