class AddOriginIdAndTypeToTransaction < ActiveRecord::Migration
  def change
    add_column    :transactions, :origin_id, :integer,  after: :transfer_account_id
    add_column    :transactions, :category1, :string,   after: :date
    rename_column :transactions, :category,  :category2
  end
end
