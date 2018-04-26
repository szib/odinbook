require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  # test 'should be valid' do
  #   user = build(:user)
  #   assert user.valid?
  # end
  #
  # test "should have an email" do
  #   user = build(:user, email: nil)
  #   assert_not user.valid?
  # end
  #
  # test "should have a password" do
  #   user = build(:user, password: nil)
  #   assert_not user.valid?
  # end
  #
  # test "should have at least 6 chr long password" do
  #   user = build(:user, password: 'aaaaa')
  #   assert_not user.valid?
  #   user = build(:user, password: 'aaaaaa')
  #   assert user.valid?
  # end
  #
  # test 'should be not valid without valid profile' do
  #   profile  = build(:profile, first_name: nil)
  #   user = build(:user, profile: profile)
  #   assert_not user.valid?
  #
  #   profile  = build(:profile, last_name: nil)
  #   user = build(:user, profile: profile)
  #   assert_not user.valid?
  #
  #   user = build(:user, profile: nil)
  #   assert_not user.valid?
  # end
  #
  # test 'should be valid without location' do
  #   profile  = build(:profile, location: nil)
  #   user = build(:user, profile: profile)
  #   assert user.valid?
  # end
  #
  # test "email address should be unique" do
  #   user = create(:user, email: 'test@example.com')
  #   dup_user = build(:user, email: 'tesT@exAmple.Com')
  #   assert_not dup_user.valid?
  # end

  test 'should friend_of? work' do
    friendship = create(:friendship)
    assert friendship.user.friend_of?(friendship.friend)
    assert friendship.friend.friend_of? friendship.user
  end

  test 'should not_friend_of? work' do
    user = build(:user)
    friendship = create(:friendship)
    assert friendship.user.not_friend_of? user
    assert friendship.friend.not_friend_of? user
  end

  test 'has_pending_friend_request?(frd)' do
    fr = create(:friend_request)
    assert fr.user.has_pending_friend_request?(fr.friend)
    assert fr.friend.has_pending_friend_request?(fr.user)
  end

  test 'has_incoming_friend_request_from?(frd)' do
    fr = create(:friend_request)
    assert fr.friend.has_incoming_friend_request_from?(fr.user)
    assert_not fr.user.has_incoming_friend_request_from?(fr.friend)
  end

  test 'has_sent_friend_request_to?(frd)' do
    fr = create(:friend_request)
    assert fr.user.has_sent_friend_request_to?(fr.friend)
    assert_not fr.friend.has_sent_friend_request_to?(fr.user)
  end

end
