class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :status, {
    confirmed: 'confirmed',
    waiting_list: 'waiting_list'
  }

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :event_id }
end