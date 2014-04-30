class Report < ActiveRecord::Base
  has_many :reports_users
  has_many :users, through: :reports_users
end
