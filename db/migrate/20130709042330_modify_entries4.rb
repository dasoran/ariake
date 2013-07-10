class ModifyEntries4 < ActiveRecord::Migration
  def up
    add_column :entries, :is_pending, :boolean
  end

  def down
    remove_column :entries, :is_pending
  end
end
