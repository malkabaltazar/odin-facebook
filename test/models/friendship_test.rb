require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @friendship = Friendship.new(user: users(:john),
                                 friend: users(:jane))
  end

  test "should be valid" do
    assert @friendship.valid?
  end
end
