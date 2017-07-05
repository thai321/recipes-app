require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name: "thai", email: "thai@example.com",
      password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: 'greate vegatable, add vegatable and oil', chef: @chef)
    @recipe.save
  end

  test 'successfully delete a recipe' do
    sign_in_as(@chef, "password") # from test_helper.rb
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end
end
