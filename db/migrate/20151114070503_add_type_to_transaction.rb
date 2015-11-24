class AddTypeToTransaction < ActiveRecord::Migration
  def change
    rename_column :transactions, :category1, :type
    rename_column :transactions, :category2, :category
  end
end
