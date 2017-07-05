require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name: "thai", email: "thai@example.com",
      password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: 'greate vegatable, add vegatable and oil', chef: @chef)
    @recipe2 = @chef.recipes.build(name: 'chicken saute', description: 'great chicken dish')
    @recipe2.save
  end

  test 'Should get chefs show' do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end

end
