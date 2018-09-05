require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: "Joe", last_name: "Example",
      birthday: 40.years.ago, gender: "male",
      email: "joe@example.com", password: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.first_name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "should friend and unfriend a user" do
    @user.save
    jane  = users(:jane)
    assert_not @user.friends.include?(jane)
    f = Friendship.create(user: @user, friend: jane)
    assert @user.friends.include?(jane)
    f.destroy
    assert_not @user.friends.include?(jane)
  end
end
