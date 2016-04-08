require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
      }
    end
    assert_template 'users/new'
  end

  test "valid signup" do
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {
          name: "flm",
          email: "flm@flm.sk",
          password: "123456",
          password_confirmation: "123456"
      }
    end
    assert_template 'users/show'
    assert_select "div>div", "Vitajte vo Venčoviskách"
  end
end
