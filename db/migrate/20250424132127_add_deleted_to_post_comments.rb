class AddDeletedToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :deleted, :boolean
  end
end
