class AddTransactionCountsToCategory < ActiveRecord::Migration
  def change
    add_column :accounts, :transactions_count, :integer, after: :init_balance
  end
end
