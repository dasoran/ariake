class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :begin_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
