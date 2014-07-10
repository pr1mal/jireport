class Report < ActiveRecord::Base
  has_many :reports_users
  has_many :users, through: :reports_users
  has_many :report_entries

  accepts_nested_attributes_for :report_entries

  def self.new_from_issues(issues)
    r = self.new
    issues.each { |i|
      r.report_entries.build(task_id: i.key,status: i.status , task_desc: i.summary, started_at: i.started_at, ended_at: i.ended_at, user: i.user)
    }
    r
  end

  def self.create_for_current_week
    now = Time.now

    report = Report.new(generated_at: now)
    activities = ReportEntry.last_week.group(:user_id)
    activities.each do |act|
      act.ended_at ||= now
    end

    report.report_entries = activities
    report
  end
end
