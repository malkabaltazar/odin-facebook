require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:john)
    @other = users(:jane)
    sign_in @user
  end

  test "personal profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'h1', text: "#{@user.first_name} #{@user.last_name}"
    assert_match "Make Post", response.body
    @user.posts.each do |post|
      assert_match post.text, response.body
    end
  end

  test "other user's profile page" do
    get user_path(@other)
    assert_template 'users/show'
    assert_select 'h1', text: "#{@other.first_name} #{@other.last_name}"
    @other.posts.each do |post|
      assert_match post.text, response.body
    end
  end
end
