class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :management_fee
      t.integer :car_fee
      t.integer :bike_fee
      t.integer :created_by
      t.integer :updated_by
      t.integer :user_id
      t.timestamp :paid_date

      t.timestamps
    end
    add_index :payments, :created_by
    add_index :payments, :user_id
    add_index :payments, :updated_by
  end
end
