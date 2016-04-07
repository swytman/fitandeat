class AddDescToDayExercies < ActiveRecord::Migration
  def change
    add_column :day_exercises, :description, :text, default: ''
  end
end
