require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name: "thai", email: "thai@example.com",
      password: "password", password_confirmation: "password")
  end

  test 'reject invalid chef update' do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { name: " ", email: "@example"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test 'successfully edit a recipe' do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { name: "tiome", email: "tiome@example.com"} }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "tiome", @chef.name
    assert_match "tiome@example.com", @chef.email
  end
end
