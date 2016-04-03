class AddUnitToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :unit_id, :integer
  end
end
