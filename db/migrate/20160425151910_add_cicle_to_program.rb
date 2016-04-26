class AddCicleToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :cycle, :boolean, :default => false
  end
end
