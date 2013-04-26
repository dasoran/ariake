class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.integer :price, null: false
      t.text :name, null: false
      t.timestamps
    end
  end
end
