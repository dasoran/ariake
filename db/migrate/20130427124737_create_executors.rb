class CreateExecutors < ActiveRecord::Migration
  def change
    create_table :executors do |t|
      t.references :user, null: false
      t.references :order, null: false
      t.timestamps
    end
    add_index :executors, :user_id
    add_index :executors, :order_id
  end
end
