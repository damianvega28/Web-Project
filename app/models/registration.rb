class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :status, {
    confirmed: "confirmed",
    waiting_list: "waiting_list",
    cancelled: "cancelled"
  }

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :event_id }

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    return if status.present?
    return unless event.present?

    if event.status != "published"
      errors.add(:event, "is not open for registration")
      return
    end

    confirmed_count = event.registrations.confirmed.count

    self.status = if confirmed_count < event.capacity
                    "confirmed"
                  else
                    "waiting_list"
                  end
  end
end