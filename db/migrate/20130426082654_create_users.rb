class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login_id, null: false
      t.string :pass_hash, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
