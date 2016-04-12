class RebuildUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.integer :telegram_id
      t.integer :telegram_name
    end
  end
end
 9