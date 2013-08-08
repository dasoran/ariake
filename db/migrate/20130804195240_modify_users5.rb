class ModifyUsers5 < ActiveRecord::Migration
  def up
    add_column :users, :permission, :string
  end

  def down
    remove_column :users, :permission
  end
end
