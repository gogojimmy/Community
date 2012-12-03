class CreateResidents < ActiveRecord::Migration
  def change
    create_table :residents do |t|
      t.string :name
      t.string :phone
      t.string :car_num
      t.string :bike_num
      t.boolean :rent
      t.string :pid
      t.integer :unit_id
      t.integer :updated_by
      t.integer :created_by

      t.timestamps
    end
    add_index :residents, :name
    add_index :residents, :phone
    add_index :residents, :car_num
    add_index :residents, :bike_num
    add_index :residents, :pid
    add_index :residents, :unit_id
    add_index :residents, :updated_by
    add_index :residents, :created_by
  end
end
