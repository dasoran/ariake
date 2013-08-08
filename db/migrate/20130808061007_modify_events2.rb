class ModifyEvents2 < ActiveRecord::Migration
  def up
    add_column :events, :is_inhibit, :boolean
  end

  def down
    remove_column :events, :is_inhibit
  end
end
