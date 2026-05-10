class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :rating, presence: true,
                     numericality: {
                       only_integer: true,
                       greater_than_or_equal_to: 1,
                       less_than_or_equal_to: 5
                     }

  validates :comment, presence: true
  validates :user_id, uniqueness: { scope: :event_id }

  validate :event_must_be_completed
  validate :user_must_have_confirmed_registration

  private

  def event_must_be_completed
    return if event.present? && event.status == "completed"

    errors.add(:event, "must be completed before it can be reviewed")
  end

  def user_must_have_confirmed_registration
    return unless user.present? && event.present?

    registration = Registration.find_by(user: user, event: event, status: "confirmed")

    return if registration.present?

    errors.add(:user, "must have attended this event before reviewing it")
  end
end