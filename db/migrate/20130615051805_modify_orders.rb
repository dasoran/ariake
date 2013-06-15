class ModifyOrders < ActiveRecord::Migration
  def up
    add_column :orders, :quantity, :integer
  end

  def down
    remove_column :orders, :quantity
  end
end
