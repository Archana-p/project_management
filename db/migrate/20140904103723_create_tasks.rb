class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status , default: "not_started"

      t.timestamps
    end
  end
end
