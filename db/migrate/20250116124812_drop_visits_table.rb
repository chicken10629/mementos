class DropVisitsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :visits
  end
end
