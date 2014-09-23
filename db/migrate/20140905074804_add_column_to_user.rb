class AddColumnToUser < ActiveRecord::Migration
  def up
    add_column :tasks, :user_id, :integer
  end

  def down
  	remove_column :users , :member_id 
  end

end
