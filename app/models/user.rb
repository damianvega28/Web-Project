class User < ApplicationRecord
  has_many :registrations
  has_many :events, through: :registrations
  has_many :organized_events, class_name: 'Event', foreign_key: 'creator_id'
  has_many :reviews
  has_many :notifications

  enum : role {
    regular: 'regular',
    admin: 'admin'
  }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  before_validation :clean_data

  def clean_data
    self.name = name.strip.titleize if name.present?
    self.email = email.strip.downcase if email.present?
  end
end