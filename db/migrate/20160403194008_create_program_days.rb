class CreateProgramDays < ActiveRecord::Migration
  def change
    create_table :program_days do |t|
      t.integer :program_id
      t.integer :order
      t.timestamps null: false
    end
  end
end
