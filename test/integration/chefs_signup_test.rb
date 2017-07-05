require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest

  test 'Should get signup path' do
    get signup_path
    assert_response :success
  end

  test 'Reject an invalid Signup' do
    get signup_path
    assert_no_difference "Chef.count" do
      post chefs_path, params: { chef: { name: " ", email: " ",
                                password: "password",
                                password_confirmation: " "}}
    end
    assert_template 'chefs/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test 'Accept an valid Signup' do
    get signup_path
    assert_difference "Chef.count", 1 do
      post chefs_path, params: { chef: { name: "tiome",
                            email: "tiome@example.com",
                            password: "123456",
                            password_confirmation: "123456" } }
    end
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end

end
