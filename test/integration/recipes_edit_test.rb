require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name: "thai", email: "thai@example.com",
      password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: 'greate vegatable, add vegatable and oil', chef: @chef)
    @recipe.save
  end

  test 'reject invalid recipe update' do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "some description"} }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test 'successfully edit a recipe' do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "Chicken"
    updated_description = "some description"
    updated_recipe = { name: updated_name, description: updated_description }
    patch recipe_path(@recipe), params: { recipe: updated_recipe }
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end
end
