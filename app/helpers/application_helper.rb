module ApplicationHelper

  def gravatar_for(user, options = { size: 80 })

    email = user.nil? ? 'noemail@example.com' : user.email.downcase
    name = user.nil? ? 'noName' : user.name

    hash = Digest::MD5.hexdigest(email)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: name, class: "img-circle")
  end

end
