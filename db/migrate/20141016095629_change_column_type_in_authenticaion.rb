class ChangeColumnTypeInAuthenticaion < ActiveRecord::Migration
  def up
  	change_column :authentications, :uid, :string
  end

  def down
  	change_column :authentications, :uid, :integer
  end
end
