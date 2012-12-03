class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :invoice_type
      t.string :num
      t.integer :amount
      t.integer :resident_id

      t.timestamps
    end
    add_index :invoices, :invoice_type
    add_index :invoices, :resident_id
    add_column :payments, :invoice_id, :integer
    add_index :payments, :invoice_id
    add_column :transactions, :invoice_id, :integer
    add_index :transactions, :invoice_id
  end
end
