class RenameBalanceAsInitBalance < ActiveRecord::Migration
  def change
    rename_column :accounts, :balance, :init_balance
  end
end
