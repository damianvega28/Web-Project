class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :registrations, dependent: :destroy
  has_many :events, through: :registrations
  has_many :organized_events, class_name: "Event", foreign_key: "creator_id", dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy

  enum :role, {
    regular: 0,
    admin: 1
  }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :role, presence: true

  before_validation :clean_data

  before_validation :set_default_role

  def clean_data
    self.name = name.strip.titleize if name.present?
    self.email = email.strip.downcase if email.present?
  end

  private

  def set_default_role
    self.role ||= :regular
  end
end