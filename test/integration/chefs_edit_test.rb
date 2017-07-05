require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name: "thai", email: "thai@example.com",
      password: "password", password_confirmation: "password")
    @admin = Chef.create!(name: "admin", email: "admin@example.com",
        password: "password", password_confirmation: "password", admin: true)
    @chef2 = Chef.create!(name: "thai2", email: "thai2@example.com",
      password: "password2", password_confirmation: "password2")

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

  test 'Accept edit attempt by admin user' do
    sign_in_as(@admin, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { name: "tiome2", email: "tiome2@example.com"} }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "tiome2", @chef.name
    assert_match "tiome2@example.com", @chef.email
  end

  test 'Redirect edit attempt by another non-admin user' do
    sign_in_as(@chef2, "password2")
    updated_name = "sean"
    updated_email = "sean@example.com"
    patch chef_path(@chef), params: { chef: { name: updated_name, email: updated_email} }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "thai", @chef.name
    assert_match "thai@example.com", @chef.email
  end

end
