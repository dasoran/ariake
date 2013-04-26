class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :event, null: false
      t.references :circle, null: false
      t.integer :attend_at, null: false, default: 0
      t.string :place, null: false
      t.datetime :goods_updated_at
      t.timestamps
    end
    add_index :entries, :event_id
    add_index :entries, :circle_id
  end
end
