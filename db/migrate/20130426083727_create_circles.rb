class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.text :name, null: false
      t.text :author
      t.timestamps
    end
  end
end
