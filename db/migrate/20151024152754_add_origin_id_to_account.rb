class AddOriginIdToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :origin_id, :integer, after: :name
  end
end
