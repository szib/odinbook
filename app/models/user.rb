class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy, autosave: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :sent_friend_requests, dependent: :destroy,
                                  class_name: 'FriendRequest',
                                  foreign_key: :user_id
  has_many :requested_friends, through: :sent_friend_requests, source: :friend

  has_many :received_friend_requests, dependent: :destroy,
                                      class_name: 'FriendRequest',
                                      foreign_key: :friend_id
  has_many :requesting_friends, through: :received_friend_requests, source: :user

  validates_associated :profile
  validates_presence_of :profile

  accepts_nested_attributes_for :profile

  def friend_of?(frd)
    friends.include? frd
  end

  def not_friend_of?(frd)
    !friend_of? frd
  end
end
