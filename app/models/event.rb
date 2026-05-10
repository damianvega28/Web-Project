class Event < ApplicationRecord
  belongs_to :category
  belongs_to :venue
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations
  has_many :reviews, dependent: :destroy

  has_rich_text :description

  enum :status, {
    draft: "draft",
    published: "published",
    ongoing: "ongoing",
    completed: "completed",
    cancelled: "cancelled"
  }

  validates :title, :description, :start_date, :end_date, :status, presence: true
  validates :capacity, presence: true,
                       numericality: {
                         only_integer: true,
                         greater_than: 0
                       }

  validate :end_date_after_start_date

  before_validation :set_default_status, on: :create

  def confirmed_registrations_count
    registrations.confirmed.count
  end

  def available_spots
    capacity - confirmed_registrations_count
  end

  def full?
    available_spots <= 0
  end

  def open_for_registration?
    published?
  end

  private

  def set_default_status
    self.status ||= "draft"
  end

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end