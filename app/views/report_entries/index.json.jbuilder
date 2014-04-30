json.array!(@report_entries) do |report_entry|
  json.extract! report_entry, :id, :user_id, :report_id, :project, :task_id, :task_desc, :msproject_task_completion_date, :started_at, :ended_at, :percentage, :eta, :status, :issues, :risk_mitigation_plans
  json.url report_entry_url(report_entry, format: :json)
end
