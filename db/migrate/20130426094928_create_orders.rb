class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :event, null: false
      t.references :circle, null: false
      t.references :user, null: false
      t.references :handout, null: false
      t.timestamps
    end
    add_index :orders, :event_id
    add_index :orders, :circle_id
    add_index :orders, :user_id
    add_index :orders, :handout_id
  end
end
