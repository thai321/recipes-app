module ApplicationHelper

  def gravatar_for(user, options = { size: 80 })

    email = user.nil? ? 'noemail@example.com' : user.email.downcase
    name = user.nil? ? 'noName' : user.name

    hash = Digest::MD5.hexdigest(email)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: name, class: "img-circle")
  end

  def show_count_recipes model
    show_count = ''
    if model.recipes.count > 0
      count = pluralize(model.recipes.count, 'recipe')
      show_count = "<li><small>#{count}</small></li>"
    end
    show_count.html_safe
  end

end
