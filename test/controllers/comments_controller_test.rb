require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    @comment = comments :orange
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post :create, comment: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete :destroy, id: @comment
    end
    assert_redirected_to login_url
  end
end
