class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :visited_at, null: false, default: -> {'CURRENT_TIMESTAMP'}

      t.timestamps
    end
  end
end
