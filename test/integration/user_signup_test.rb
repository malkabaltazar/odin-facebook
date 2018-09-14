require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { first_name: "",
                                 email: "user@invalid",
                                 password: "foo",
                                 password_confirmation: "bar" } }
    end
    assert_template 'devise/registrations/new'
    assert_select 'form[action="/users"]'
    assert_select 'div#error_explanation'
  end

  test "valid signup information" do
    get new_user_registration_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { first_name: "John",
                                 last_name: "Doe",
                                 email: "johndoe@example.com",
                                 birthday: Date.today,
                                 gender: "male",
                                 password: "foobar",
                                 password_confirmation: "foobar" } }
    end
    follow_redirect!
    assert_template 'posts/index'
    assert_not flash.empty?
    assert_select 'a[href=?]', "/users/sign_out", text: "Log Out"
  end
end
