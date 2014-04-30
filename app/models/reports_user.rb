class ReportsUser < ActiveRecord::Base
  belongs_to :report
  belongs_to :user

  validates :report, presence: true
  validates :user, presence: true
end
