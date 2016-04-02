require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Domov | Venčoviská"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Nápoveda | Venčoviská"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "O nás | Venčoviská"
  end
end
