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

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates_associated :profile
  validates_presence_of :profile

  accepts_nested_attributes_for :profile

  scope :possible_friends_for, -> (id) { where('id <> ?', id) }

  def friend_of?(frd)
    friends.include? frd
  end

  def not_friend_of?(frd)
    !friend_of? frd
  end

  def number_of_friend_requests
    requesting_friends.count
  end

  def has_pending_friend_request?(frd)
    requested_friends.include?(frd) || requesting_friends.include?(frd)
  end

  def has_incoming_friend_request_from?(frd)
    requesting_friends.include?(frd)
  end

  def has_sent_friend_request_to?(frd)
    requested_friends.include?(frd)
  end
end
