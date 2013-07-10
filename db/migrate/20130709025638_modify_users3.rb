class ModifyUsers3 < ActiveRecord::Migration
  def up
    change_column :users, :login_id, :string, :null => true
    change_column :users, :pass_hash, :string, :null => true
  end

  def down
    change_column :users, :login_id, :string, :null => false
    change_column :users, :pass_hash, :string, :null => false
  end
end
