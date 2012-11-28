class AddUserStampToModels < ActiveRecord::Migration
  def change
    add_column :units, :created_by, :integer
    add_index :units, :created_by
    add_column :units, :updated_by, :integer
    add_index :units, :updated_by
    add_column :users, :created_by, :integer
    add_index :users, :created_by
    add_column :users, :updated_by, :integer
    add_index :users, :updated_by
    add_column :buildings, :created_by, :integer
    add_index :buildings, :created_by
    add_column :buildings, :updated_by, :integer
    add_index :buildings, :updated_by
  end
end
