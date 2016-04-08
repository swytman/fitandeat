class AddSubscriptions < ActiveRecord::Migration
  def change

    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :telegram_id
      t.integer :program_id
      t.integer :missed_days, default: 0
      t.date :start_date
    end

    add_column :users, :telegram_name, :string

  end
end
