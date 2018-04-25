module Befriendable
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :friend, class_name: 'User'

    validate :not_self
    validates_presence_of :user, :friend
    validates_uniqueness_of :user, scope: :friend
  end

  def not_self
    errors.add(:user, 'Cannot send a friend request to self.') if user == friend
  end

end
