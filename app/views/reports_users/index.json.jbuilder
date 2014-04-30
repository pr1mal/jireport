json.array!(@reports_users) do |reports_user|
  json.extract! reports_user, :id, :report_id, :user_id, :vac, :on_track, :delay_details, :recovery_plan, :comments, :user_report_ready
  json.url reports_user_url(reports_user, format: :json)
end
