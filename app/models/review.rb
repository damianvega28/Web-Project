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

  validate :only_one_review_per_person
  validate :event_must_be_completed
  validate :user_must_have_confirmed_registration

  private

  def only_one_review_per_person
    return unless user.present? && event.present?

    existing_review = Review.find_by(user: user, event: event)
    return if existing_review.blank? || existing_review == self

    errors.add(:base, "Only one review per person")
  end

  def event_must_be_completed
    return if event.present? && event.completed?

    errors.add(:event, "must be completed before it can be reviewed")
  end

  def user_must_have_confirmed_registration
    return unless user.present? && event.present?

    registration = Registration.find_by(user: user, event: event, status: "confirmed")

    return if registration.present?

    errors.add(:user, "must have attended this event before reviewing it")
  end
end