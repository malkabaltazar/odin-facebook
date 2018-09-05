require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:john)
  end

  test "layout links" do
    get root_path
    assert_template 'devise/registrations/new'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", new_user_password_path
    get new_user_password_path
    assert_select "h2", "Find Your Account"
    get new_user_session_path
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", new_user_password_path
    get root_path
    sign_in @user
    get user_path(@user)
    assert_select "a[href=?]", user_path
    assert_select "a[href=?]", users_path
    assert_match @user.notifications.where(notifiable_type: "User").count.to_s, response.body
    assert_select "a[href=?]", edit_user_registration_path(@user)
    assert_select "a[href=?]", destroy_user_session_path
  end
end
