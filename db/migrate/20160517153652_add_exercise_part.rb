class AddExercisePart < ActiveRecord::Migration
  def change
    create_table :exercise_steps do |t|
      t.string :title
      t.integer :exercise_id
      t.text :description
      t.timestamps
    end

    add_attachment :exercise_steps, :image

  end
end
