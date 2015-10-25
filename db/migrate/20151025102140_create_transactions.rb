class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.boolean :transfer
      t.integer :account_id
      t.integer :transfer_account_id
      t.date :date
      t.string :category
      t.text :note
      t.decimal :amount, precision: 20, scale: 5

      t.timestamps null: false
    end
  end
end
