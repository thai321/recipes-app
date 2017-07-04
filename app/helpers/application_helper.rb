module ApplicationHelper

  def gravatar_for(user, options = { size: 80 })
    hash = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "img-circle")
  end

end
