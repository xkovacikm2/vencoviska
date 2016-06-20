require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    @regulars_comment = comments :most_recent
    @other_comment = comments :comment1
    @regular = users :anton
    @area = areas :one
    @admin = users :flm
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post :create, comment: {content: "Lorem ipsum"}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete :destroy, id: @regulars_comment
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy own comment when logged in as regular user" do
    log_in_as @regular
    assert_no_difference 'Comment.count' do
      delete :destroy, id: @regulars_comment
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy others comment when logged in as regular user" do
    log_in_as @regular
    assert_no_difference 'Comment.count' do
      delete :destroy, id: @other_comment
    end
    assert_redirected_to root_url
  end

  test "should delete comment when logged in as admin" do
    log_in_as @admin
    assert_difference 'Comment.count', -1 do
      delete :destroy, id: @other_comment
    end
    assert_redirected_to @admin
    assert_not_empty flash
  end
end
