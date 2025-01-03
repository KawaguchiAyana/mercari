class AddSoldOutToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :sold_out, :boolean
  end
end
