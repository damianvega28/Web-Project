class Venue < ApplicationRecord
  has_many :events

  validates :name, :address, :capacity, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
end