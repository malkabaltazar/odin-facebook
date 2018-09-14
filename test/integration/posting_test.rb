require 'test_helper'

class PostingTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:john)
  end

  test "post interface" do
    sign_in (@user)
    get root_path
    # Invalid submission
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { text: "" } }
    end
    # Valid submission
    text = "An example post"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { text: text } }
    end
    follow_redirect!
    assert_match text, response.body
    # Visit different user
    sign_in users(:jane)
    get user_path(@user)
    assert_select 'a', text: 'Delete', count: 0
    first_post = @user.posts.first
    assert_no_difference 'Post.count' do
      delete post_path(first_post)
    end
    # Delete post
    sign_in (@user)
    get user_path(@user)
    assert_select 'a', text: 'Delete'
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
  end
end
