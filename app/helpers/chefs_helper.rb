module ChefsHelper
  def show_count_recipes chef
    show_count = ''
    if chef.recipes.count > 0
      count = pluralize(chef.recipes.count, 'recipe')
      show_count = "<li><small>#{count}</small></li>"
    end
    show_count.html_safe
  end
end
