require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @miyamoto = users(:miyamoto)
    @tomoe = users(:tomoe)
    @gennosuke = users(:gennosuke)
    @nakamura = users(:nakamura)
    @user = User.new(email: "user@example.com", password: "foobar")
    @user.build_profile(first_name: 'John', last_name: 'Doe',
                        location: 'United Kingdom')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test "should have an email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "should have a password" do
    @user.password = nil
    assert_not @user.valid?
  end

  test "should have at least 6 chr long password" do
    @user.password = 'aaaaa'
    assert_not @user.valid?
    @user.password = 'aaaaaa'
    assert @user.valid?
  end

  test 'should be not valid without valid profile' do
    @user.profile.first_name = nil
    assert_not @user.valid?
    @user.profile.last_name = nil
    assert_not @user.valid?
    @user.profile = nil
    assert_not @user.valid?
  end

  test 'should be valid without location' do
    @user.profile.location = nil
    assert @user.valid?
  end

  test "email address should be unique" do
    dup_user = @miyamoto.dup
    dup_user.email = @miyamoto.email.upcase
    @miyamoto.save
    assert_not dup_user.valid?
  end

  test 'should friend_of? work' do
    assert @miyamoto.friend_of? @tomoe
    assert @miyamoto.friend_of? @gennosuke
  end

  test 'should not_friend_of? work' do
    assert @nakamura.not_friend_of? @tomoe
    assert @nakamura.not_friend_of? @gennosuke
    assert @nakamura.not_friend_of? @nakamura
  end

  test 'has_pending_friend_request?(frd)' do
    assert @nakamura.has_pending_friend_request?(@miyamoto)
    assert @miyamoto.has_pending_friend_request?(@nakamura)
  end

  test 'has_incoming_friend_request_from(frd)' do
    assert_not @nakamura.has_incoming_friend_request_from(@miyamoto)
    assert @miyamoto.has_incoming_friend_request_from(@nakamura)
  end

  test 'has_sent_friend_request_to(frd)' do
    assert @nakamura.has_sent_friend_request_to(@miyamoto)
    assert_not @miyamoto.has_sent_friend_request_to(@nakamura)
  end

end
