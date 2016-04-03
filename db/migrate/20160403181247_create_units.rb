class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :short_title
      t.string :title
      t.string :few_title
      t.string :many_title
      t.timestamps null: false
    end
  end
end
