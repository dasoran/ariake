class ModifyEntries3 < ActiveRecord::Migration
  def up
    add_column :entries, :notice, :text
  end

  def down
    remove_column :entries, :notice
  end
end
