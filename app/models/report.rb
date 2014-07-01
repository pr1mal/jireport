class Report < ActiveRecord::Base
  has_many :reports_users
  has_many :users, through: :reports_users
  has_many :report_entries

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
