class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: %i[facebook]

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

  scope :possible_friends_of, -> (user) { where.not(id: user.friends_ids.to_a) }

  include Gravtastic
  gravtastic size: 100, default: 'mm'

  def friend_of?(frd)
    friends.include? frd
  end

  def friends_ids
    friends.map { |f| f.id } << id
  end

  def pending_friends
    ids = requested_friends.pluck(:friend_id) + requesting_friends.pluck(:user_id)
    User.where('id in (?)', ids)
  end

  def timeline
    Post.where("author_id in (?)", friends_ids)
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

  def self.from_onmiauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      names = auth.info.name.split(' ')
      user.password = Devise.friendly_token[0,20]
      user.profile = Profile.new
      user.profile.first_name = names[0]
      user.profile.last_name = names[1]
      user.profile.location = ''
      puts auth
    end
  end
end
