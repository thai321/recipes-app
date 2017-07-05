require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name: "thai", email: "thai@example.com",
                          password: "password")
  end

  test 'Invalid login is rejected' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: "thai2@example.com", password: " "} }
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    #count: 0 means logout link should not be there since
    # this is invalid login
    get root_path
    assert flash.empty?
  end

  test 'Valid login credentials accpeted and begin session' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: "thai@example.com", password: "password"} }
    assert_redirected_to @chef
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    #count: 0 means logout link should not be there since
    # this is invalid login
    assert_select "a[href=?]", chef_path(@chef)
    assert_select "a[href=?]", edit_chef_path(@chef)
  end
end
