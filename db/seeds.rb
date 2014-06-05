# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

User.create([
  { full_name: 'Sylvester Stallone', jira_name: 'sstallone' },
  { full_name: 'Ricky Martin', jira_name: 'rmartin' },
  { full_name: 'Pablo Picasso', jira_name: 'ppicasso' },
  { full_name: 'Joseph Stalin', jira_name: 'jstalin' },
  { full_name: 'Richard Stallman', jira_name: 'sstallman' },
  { full_name: 'Steve Ballmer', jira_name: 'sballmer' },
])

Report.delete_all

Report.create([
  { generated_at: 7.days.ago },
  { generated_at: Time.now }
])

class Array
  def random
    self[rand(self.size)]
  end
end

projects = ["VRF", "NI2"]
dates = []
1.upto(10) {|n| dates << n.days.ago }
entries = []
User.all.each do |u|
  1.upto(rand(10)) do    
    e = {}
    e[:user_id] = u.id
    e[:project] = projects.random
    e[:task_id] = rand(500)
    e[:task_desc] = "lorem ipsum"
    e[:started_at] = dates.random
    e[:ended_at] = nil
    e[:percentage] = rand(100).to_s
    entries << e
  end
end

require 'pp'
pp entries

ReportEntry.delete_all
ReportEntry.create(entries)