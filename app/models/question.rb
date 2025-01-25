class Question < ApplicationRecord
  belongs_to :book
  belongs_to :user
  scope :asked_today, ->(user) { where(user: user, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

end
