class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :content, null: false
      t.datetime :start_time, null: false
      t.datetime :deadline_time
      t.datetime :end_time
      t.integer :status, null: false

      t.timestamps
    end
  end
end
