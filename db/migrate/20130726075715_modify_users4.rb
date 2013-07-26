class ModifyUsers4 < ActiveRecord::Migration
  def up
    add_column :users, :is_pending, :boolean
  end

  def down
    remove_column :users, :is_pending
  end
end
