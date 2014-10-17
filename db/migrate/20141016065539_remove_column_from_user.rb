class RemoveColumnFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :uid
    remove_column :users, :provider
    remove_column :users, :oauth_token
    remove_column :users, :oauth_expires_at
  end

  def down
    add_column :users, :oauth_expires_at, :datetime
    add_column :users, :oauth_token, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :integer
  end
end
