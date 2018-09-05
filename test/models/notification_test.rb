require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @notification = Notification.new(user: User.first,
      notifiable: User.second)
  end

  test "should be valid" do
    assert @notification.valid?
  end
end
