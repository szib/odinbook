require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase

  def setup
    @miyamoto = users(:miyamoto)
    @tomoe = users(:tomoe)
    @gennosuke = users(:gennosuke)
    @nakamura = users(:nakamura)
  end

  test 'should create inverse friendship' do
    assert_not @gennosuke.friends.include? @tomoe
    assert_not @tomoe.friends.include? @gennosuke
    assert @tomoe.friends.include? @miyamoto
    @tomoe.friends << @gennosuke
    assert @gennosuke.friends.include? @tomoe
    assert @tomoe.friends.include? @gennosuke
    assert @tomoe.friends.include? @miyamoto
  end

  test 'should destroy inverse friendship' do
    @tomoe.friends << @gennosuke
    assert @tomoe.friends.include? @miyamoto
    assert @gennosuke.friends.include? @tomoe
    assert @tomoe.friends.include? @gennosuke
    @tomoe.friends.destroy @gennosuke
    assert_not @gennosuke.friends.include? @tomoe
    assert_not @tomoe.friends.include? @gennosuke
    assert @tomoe.friends.include? @miyamoto
  end

  test 'should not add a friend twice' do
    assert_not @tomoe.friends.include? @gennosuke
    @tomoe.friends << @gennosuke
    assert @tomoe.friends.include? @gennosuke
    # TODO: assert_no_difference ???
    assert_raises {
        @tomoe.friends << @gennosuke
    }
  end

  test 'should not add self as a friend' do
    assert_raises {
      @nakamura.friends << @nakamura
    }
  end

end
