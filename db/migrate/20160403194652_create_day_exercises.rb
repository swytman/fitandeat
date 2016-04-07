class CreateDayExercises < ActiveRecord::Migration
  def change
    create_table :day_exercises do |t|
      t.integer :program_day_id
      t.integer :exercise_id
      t.integer :count, default: 0
      t.integer :order
      t.timestamps null: false
    end
  end
end
