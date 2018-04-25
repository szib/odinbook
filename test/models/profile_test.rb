require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def setup
    @user = build(:user)
  end

  test 'profile should be valid' do
    assert @user.profile.valid?
  end

  test 'profile should be invalid without first name' do
    @user.profile.first_name = nil
    assert_not @user.profile.valid?
  end

  test 'profile should be invalid without last name' do
    @user.profile.last_name = nil
    assert_not @user.profile.valid?
  end

  test 'profile should be valid without location' do
    @user.profile.location = nil
    assert @user.profile.valid?
  end

  test 'should capitalize name and location' do
    str = 'string'
    @user.profile.first_name = str
    @user.profile.last_name = str
    @user.profile.send(:capitalize_names)
    assert_equal @user.profile.first_name, str.capitalize
    assert_equal @user.profile.last_name, str.capitalize
  end

  test 'should be invalid with short or long first name' do
    @user.profile.first_name = 'a'
    assert_not @user.profile.valid?
    @user.profile.first_name = 'a' * 51
    assert_not @user.profile.valid?
  end

  test 'should be invalid with short or long last name' do
    @user.profile.last_name = 'a'
    assert_not @user.profile.valid?
    @user.profile.last_name = 'a' * 51
    assert_not @user.profile.valid?
  end

end
