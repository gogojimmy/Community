class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :management_fee, default: 0
      t.integer :car_fee, default: 0
      t.integer :bike_fee, default: 0
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
