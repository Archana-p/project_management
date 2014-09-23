class CreateAttachments < ActiveRecord::Migration
  def up
    create_table :attachments do |t|
      t.integer :task_id
      t.string :file

      t.timestamps
    end
  end
  def down
  end
end
