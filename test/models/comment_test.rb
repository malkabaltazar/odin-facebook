require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = users(:john).comments.new(post: posts(:one), text: "example comment")
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "text should be present" do
    @comment.text = "     "
    assert_not @comment.valid?
  end
end
