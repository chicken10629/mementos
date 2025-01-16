class ChangeNullOnUserIdInVisits < ActiveRecord::Migration[6.1]
  def change
    change_column_null :visits, :user_id, true
  end
end
