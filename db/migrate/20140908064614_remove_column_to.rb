class RemoveColumnTo < ActiveRecord::Migration
  def up
  	remove_column :tasks, :file
  end

  def down
  end
end
