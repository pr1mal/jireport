class User < ActiveRecord::Base
  validates :full_name,
            uniqueness: true,
            format: {
              with: /\A\w{1,30} \w{1,30}\z/,
              message: 'should consist of 2 words separated by a space',
            }

  validates :jira_name,
            uniqueness: true,
            format: {
              with: /\A\w{1,30}\z/,
              message: 'should consist of alphanumeric characters',
            }

  def to_s
    "#{full_name} <#{jira_name}>"
  end
end
