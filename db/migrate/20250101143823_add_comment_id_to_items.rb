class AddCommentIdToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :Comment_id, :integer
  end
end