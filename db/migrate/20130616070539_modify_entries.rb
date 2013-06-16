class ModifyEntries < ActiveRecord::Migration
  def up
    add_column :entries, :map_layout_id, :integer
    add_column :entries, :sub_place, :string
    remove_column :entries, :place
  end

  def down
    remove_column :entries, :map_layout_id
    remove_column :entries, :sub_place
    add_column :entries, :place, :string
  end
end
