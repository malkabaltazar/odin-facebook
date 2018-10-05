module UsersHelper
  def gravatar_for(user, size: 80)
    if user.image
      url = "#{user.image}?height=#{size}&width=#{size}"
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    end
    image_tag(url, alt: user.first_name, class: "gravatar")
  end
end
