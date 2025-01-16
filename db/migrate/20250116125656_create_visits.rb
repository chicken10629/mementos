class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits do |t|
      t.references :user, null: true, foreign_key: true
      t.datetime :visited_at, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
