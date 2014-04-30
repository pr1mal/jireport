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
