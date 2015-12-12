class AddCounterpartAccountIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :counterpart_account_id, :integer, after: :counterpart_id
  end
end
