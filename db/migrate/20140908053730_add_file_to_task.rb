class AddFileToTask < ActiveRecord::Migration
  def up
    add_column :tasks, :file, :string
  end
  
end
