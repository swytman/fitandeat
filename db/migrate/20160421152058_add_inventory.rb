class AddInventory < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
    create_join_table :equipment, :exercises
    add_attachment :equipment, :icon

  end
end
