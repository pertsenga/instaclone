# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: {case_sensitive: false}

  has_many :photos, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :friendships, dependent: :delete_all

  def friends
    User.where(id: friend_ids)
  end

  def friend_ids
    Friendship.of_user(self).accepted.pluck(:user_id, :friend_id).flatten.uniq - [self.id]
  end
end
