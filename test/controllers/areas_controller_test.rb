require 'test_helper'

class AreasControllerTest < ActionController::TestCase
  def setup
    @regular = users :anton
    @admin = users :flm
    @city = cities :Bratislava
    @area = areas :one
    @a_c = area_colors :one
  end

  test "should get new when logged in" do
    log_in_as @regular
    get :new, id: @city.id
    assert_response :success
    assert_select "title", "Pridať zónu | Venčoviská"
    assert_select "div", class: "map-drawing-tool"
  end

  test "should redirect new when not logged in" do
    get :new, id: @city.id
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "show area as regular user" do
    log_in_as @regular
    get :show, id: @area
    assert_select "h1", text: "Zona #{@area.name}"
    assert_select "div", class: "map"
    assert_select "a", href: @city
  end

  test "show area as admin" do
    log_in_as @admin
    get :show, id: @area
    assert_select "h1", text: "Zona #{@area.name}"
    assert_select "div", class: "map"
    assert_select "a", href: @city
    assert_select "a", text: "Zmazať"
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Area.count' do
      delete :destroy, id: @area
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when not admin" do
    log_in_as @regular
    assert_no_difference 'Area.count' do
      delete :destroy, id: @area
    end
    assert_redirected_to root_url
  end

  test "should destroy area when logged in as admin" do
    log_in_as @admin
    assert_difference 'Area.count', -1 do
      delete :destroy, id: @area
    end
    assert_redirected_to @city
  end
end
