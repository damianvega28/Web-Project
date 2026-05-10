class Notification < ApplicationRecord
  belongs_to :user

  enum :notification_type, {
    registration: "registration",
    waitlist: "waitlist",
    reminder: "reminder",
    event: "event",
    cancellation: "cancellation",
    review: "review"
  }

  validates :title, :message, :notification_type, presence: true
  validates :read, inclusion: { in: [true, false] }
end