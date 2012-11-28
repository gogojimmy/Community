class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.integer :balance, default: 0
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
    add_index :accounts, :name
    add_index :accounts, :created_by
    add_index :accounts, :updated_by
  end
end
