class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, null: false
      t.references :handout, null: false
      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :handout_id
  end
end
