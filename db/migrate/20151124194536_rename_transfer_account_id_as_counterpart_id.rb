class RenameTransferAccountIdAsCounterpartId < ActiveRecord::Migration
  def change
    rename_column :transactions, :transfer_account_id, :counterpart_id
  end
end
