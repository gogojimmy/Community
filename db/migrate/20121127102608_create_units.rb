class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :building_id
      t.string :num
      t.string :address
      t.float :pin
      t.integer :management_fee

      t.timestamps
    end
    add_index :units, :building_id
  end
end
