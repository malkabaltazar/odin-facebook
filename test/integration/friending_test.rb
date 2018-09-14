require 'test_helper'

class FriendingTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:john)
    @other = users(:jack)
  end

  test "should friend and unfriend user" do
    sign_in @user
    get users_path
    assert_difference "Notification.count", 1 do
      post notifications_path, params: { notification: { user: @other.id } }
    end
    sign_in @other
    get users_path
    assert_difference 'Friendship.count', 2 do
      assert_difference 'Notification.count', -1 do
        post friendships_path, params: { friendship: { user: @user.id } }
      end
    end
    get user_path(@user), params: { partial: "friends" }
    assert_difference 'Friendship.count', -2 do
      delete friendship_path(Friendship.last)
    end
  end

  test "should delete friend request" do
    sign_in @user
    get users_path
    assert_difference "Notification.count", 1 do
      post notifications_path, params: { notification: { user: @other.id } }
    end
    sign_in @other
    get users_path
    assert_difference 'Notification.count', -1 do
      delete notification_path(Notification.last)
    end
    assert_difference "Notification.count", 1 do
      post notifications_path, params: { notification: { user: @user.id } }
    end
    assert_difference 'Notification.count', -1 do
      delete notification_path(Notification.last)
    end
  end
end
