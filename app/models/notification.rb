class Notification < ApplicationRecord
  belongs_to :user
  validates :title, :message, presence: true

  enum :notification_type {
    registration: 'registration',
    waitlist: 'waitlist',
    reminder: 'reminder',
    event: 'event',
    cancellation: 'cancellation',
    review: 'review'
  }

  validates :title, :message, :notification_type, presence: true
end