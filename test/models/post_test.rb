require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = users(:john).posts.new(text: "example post")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "text should be present" do
    @post.text = "     "
    assert_not @post.valid?
  end
end
