class Issue < ActiveRecord::Base
  belongs_to :user, foreign_key: :assignee, primary_key: :jira_name
end
