class CreateTableExercise < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :title
      t.text :description
      t.timestamps null: false
    end
  end
end
