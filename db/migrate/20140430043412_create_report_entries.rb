class CreateReportEntries < ActiveRecord::Migration
  def change
    create_table :report_entries do |t|
      t.references :user, index: true
      t.references :report, index: true
      t.string :project
      t.string :task_id
      t.string :task_desc
      t.datetime :msproject_task_completion_date
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :percentage
      t.datetime :eta
      t.string :status
      t.text :issues
      t.text :risk_mitigation_plans

      t.timestamps
    end
  end
end
