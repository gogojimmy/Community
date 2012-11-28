class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :from_account_id
      t.integer :to_account_id
      t.integer :transaction_type_id
      t.integer :amount
      t.integer :created_by
      t.integer :updated_by
      t.text :description

      t.timestamps
    end
    add_index :transactions, :from_account_id
    add_index :transactions, :to_account_id
    add_index :transactions, :transaction_type_id
    add_index :transactions, :created_by
    add_index :transactions, :updated_by
  end
end
