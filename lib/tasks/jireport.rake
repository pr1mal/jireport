namespace :jireport do
  desc "Generate report for current week (Monday-Friday)"
  task :report_cur_week => :environment do
    Report.create_for_current_week
  end
  
  desc "Fetch new data from Jira"
  task :fetch => :environment do
    
  end
end