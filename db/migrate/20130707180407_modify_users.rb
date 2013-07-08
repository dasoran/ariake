class ModifyUsers < ActiveRecord::Migration
  def up
    add_column :users, :administrator, :boolean
  end

  def down
    remove_column :users, :administrator
  end
end
