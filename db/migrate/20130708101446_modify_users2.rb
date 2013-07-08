class ModifyUsers2 < ActiveRecord::Migration
  def up
    add_column :users, :color, :string
  end

  def down
    remove_column :users, :color
  end
end
