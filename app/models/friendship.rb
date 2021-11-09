class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates :user_id, :friend_id, presence: true

  scope :accepted, -> { where.not accepted_at: nil }
  scope :rejected, -> { where.not rejected_at: nil }
  scope :pending, -> { where accepted_at: nil, rejected_at: nil }

  scope :of_user, -> (user) { where("user_id = ? OR friend_id = ?", user.id, user.id) }
end
