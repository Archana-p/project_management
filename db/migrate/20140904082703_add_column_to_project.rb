class AddColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :admin_id, :integer
  end
end
