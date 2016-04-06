require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user=User.new name: "Example User", email: "user@example.com",
        password: "trololo", password_confirmation: "trololo"
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name="        "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email="        "
    assert_not @user.valid?
  end

  test "name too long" do
    @user.name = "a"*256
    assert_not @user.valid?
  end

  test "email too long" do
    @user.email = "a"*244 + "@example.com"
    assert_not @user.valid?
  end

  test "valid email validation" do
    addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last2@foo.jp alice+bob@baz.cn]
    addresses.each do |address|
      @user.email=address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "invalid email validation" do
    addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |address|
      @user.email=address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test "email uniqueness" do
    user_dup = @user.dup
    @user.save
    assert_not user_dup.valid?, "#{user_dup.inspect} should have non-unique email"

    user_dup.email.upcase!
    assert_not user_dup.valid?, "#{user_dup.inspect} should have non-unique email"
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " "*6
    assert_not @user.valid?
  end

  test "password should be at least 6 chars long" do
    @user.password = @user.password_confirmation = " "*5
    assert_not @user.valid?
  end
end
