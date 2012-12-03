class RemoveResidentAttributesFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :role
    remove_column :users, :car_num
    remove_column :users, :bike_num
    remove_column :users, :rent
    remove_column :users, :unit_id
    remove_column :users, :updated_by
    remove_column :users, :created_by
    remove_column :payments, :user_id
    add_column :payments, :resident_id, :integer
    add_index :payments, :resident_id
  end
end
