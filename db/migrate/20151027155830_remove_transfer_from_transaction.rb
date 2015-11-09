class RemoveTransferFromTransaction < ActiveRecord::Migration
  def up
    remove_column :transactions, :transfer
  end

  def down
    add_column :transactions, :transfer, :boolean, after: :transfer_account_id
  end
end
