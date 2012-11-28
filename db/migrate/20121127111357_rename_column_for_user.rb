class RenameColumnForUser < ActiveRecord::Migration
  def change
    rename_column :users, :cell_id, :unit_id
  end
end
