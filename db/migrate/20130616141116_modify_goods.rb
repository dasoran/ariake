class ModifyGoods < ActiveRecord::Migration
  def up
    add_column :goods, :is_generic, :boolean
  end

  def down
    remove_column :goods, :is_generic
  end
end
