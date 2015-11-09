class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :currency,       default: "TWD"
      t.decimal :exchange_rate, default: 1,     precision: 20, scale: 5
      t.decimal :balance,       default: 0,     precision: 20, scale: 5

      t.timestamps null: false
    end
  end
end
