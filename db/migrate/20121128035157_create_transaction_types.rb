class CreateTransactionTypes < ActiveRecord::Migration
  def change
    create_table :transaction_types do |t|
      t.string :name, null: false
      t.text :description
      t.string :self_type
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
    add_index :transaction_types, :created_by
    add_index :transaction_types, :updated_by
  end
end
