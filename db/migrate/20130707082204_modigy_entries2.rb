class ModigyEntries2 < ActiveRecord::Migration
  def up
    remove_column :entries, :event_id
  end

  def down
    add_column :entries, :event_id, :integer
  end
end
