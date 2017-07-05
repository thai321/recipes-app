require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name: "thai", email: "thai@example.com",
      password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(name: "thai2", email: "thai2@example.com",
      password: "password2", password_confirmation: "password2")
  end

  test 'Should get chefs index' do
    get chefs_path
    assert_response :success
  end

  test 'Should show list of chefs' do
    get chefs_path
    assert_template 'chefs/index'

    assert_match @chef.name, response.body
    assert_select "a[href=?]", chef_path(@chef), text: @chef.name.capitalize

    assert_match @chef2.name, response.body
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.name.capitalize
  end

  test 'Should delete chef' do
    sign_in_as(@chef2, "password2")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end
