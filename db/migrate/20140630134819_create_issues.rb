class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :key
      t.string :status
      t.string :summary
      t.string :project
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :created_at
      t.datetime :updated_at
      t.string :assignee
    end
  end
end
