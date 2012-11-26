class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :username,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.string :name
      t.string :phone
      t.string :car_num
      t.string :bike_num
      t.boolean :rent
      t.string :pid
      t.integer :cell_id

      t.timestamps
    end

    add_index :users, :username,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :name
    add_index :users, :phone
    add_index :users, :pid
    add_index :users, :cell_id
  end
end
