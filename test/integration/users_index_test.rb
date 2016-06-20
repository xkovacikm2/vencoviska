require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users :flm
    @regular = users :anton
  end

  test "index as admin including pagination and delete links" do
    log_in_as @admin
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user)
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'Zmazať'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@regular)
    end
  end

  test "index as non-admin" do
    log_in_as(@regular)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
