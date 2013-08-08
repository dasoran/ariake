class ModifyUsers6 < ActiveRecord::Migration
  def up
    remove_column :users, :is_pending
    remove_column :users, :administrator
  end

  def down
    add_column :users, :is_pending, :boolean
    add_column :users, :administrator, :boolean
  end
end
