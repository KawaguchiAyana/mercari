class CreateCourts < ActiveRecord::Migration[7.2]
  def change
    create_table :courts do |t|
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
