class AddChefReferenceToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_reference :recipes, :chef, foreign_key: true
  end
end
