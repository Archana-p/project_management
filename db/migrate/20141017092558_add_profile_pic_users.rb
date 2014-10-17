class AddProfilePicUsers < ActiveRecord::Migration
  def up
  	add_column :users, :profile_pic, :string
  end

  def down
  end
end
