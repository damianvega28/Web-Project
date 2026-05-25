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

  validate :event_must_be_published, on: :create

  before_validation :set_registered_at, on: :create
  before_validation :assign_status, on: :create

  def cancel!
    was_confirmed = confirmed?

    update!(status: "cancelled")

    promote_first_waiting_list_registration if was_confirmed
  end

  private

  def event_must_be_published
    return if event.present? && event.published?

    errors.add(:event, "is not open for registration")
  end

  def assign_status
    return unless event.present?
    return unless event.published?

    confirmed_count = event.registrations.confirmed.count

    self.status = if confirmed_count < event.capacity
                    "confirmed"
                  else
                    "waiting_list"
                  end
  end

  def set_registered_at
    self.registered_at ||= Time.current
  end

  def promote_first_waiting_list_registration
    next_registration = event.registrations
                             .waiting_list
                             .order(:registered_at)
                             .first

    next_registration&.update!(status: "confirmed")
  end
end