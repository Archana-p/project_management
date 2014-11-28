class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :compare
      t.string :commit

      t.timestamps
    end
  end
end
