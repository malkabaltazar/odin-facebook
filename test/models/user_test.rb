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

  test "associated microposts should be destroyed" do
    @user.save
    @user.posts.create!(text: "example post")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
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

  test "feed should have the right posts" do
    john = users(:john)
    jane = users(:jane)
    jack = users(:jack)
    # Posts from friend
    jane.posts.each do |post_friend|
      assert john.feed.include?(post_friend)
    end
    # Posts from self
    john.posts.each do |post_self|
      assert john.feed.include?(post_self)
    end
    # Posts from nonfriend
    jack.posts.each do |post_nonfriend|
      assert_not john.feed.include?(post_nonfriend)
    end
  end
end
