require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: "user@example.com", password: "foobar")
    @user.build_profile(first_name: 'John', last_name: 'Doe',
                        location: 'United Kingdom')
  end

  test 'should be valid' do
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

  test 'should not be valid ' do
  end



  # test "the truth" do
  #   assert true
  # end
end
