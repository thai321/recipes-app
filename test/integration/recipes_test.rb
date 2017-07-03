require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name: 'Thai', email: 'thai@example.com')
    @recipe = Recipe.create(name: "vegetable saute", description: 'greate vegatable, add vegatable and oil', chef: @chef)
    @recipe2 = @chef.recipes.build(name: 'chicken saute', description: 'great chicken dish')
    @recipe2.save
  end

  test 'Should get recipes index' do
    get recipes_url
    assert_response :success
  end

  test 'Should get recipes listing' do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe2.name, response.body
    # assert_match @recipe2.name, response.body
  end

end
