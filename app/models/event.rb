class Event < ApplicationRecord
  belongs_to :category
  belongs_to :venue
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  has_many :registrations
  has_many :users, through: :registrations
  has_many :reviews

  enum :status, {
    draft: 'draft',
    published: 'published',
    ongoing: 'ongoing',
    completed: 'completed',
    cancelled: 'cancelled'
  }

  validates :title, :description, :start_date, :end_date, :status, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end