class CreateProjectUser < ActiveRecord::Migration
  def up
  	 create_table :projects_users do |t|
      t.integer :user_id
      t.integer :project_id
   end
  end

  def down
  drop_table :projects_Users
  end
end
