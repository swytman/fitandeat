class RebuildUsers < ActiveRecord::Migration
  def change
    drop_table :users if User.table_exists?
    create_table(:users) do |t|
      t.integer :telegram_id
      t.integer :telegram_name
    end
  end
end
