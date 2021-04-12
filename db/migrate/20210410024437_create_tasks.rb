class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks, comment: 'List of tasks' do |t|
      t.string :title, limit: 500, null: false, comment: 'Task title'

      t.timestamps
    end
  end
end
