module ApplicationHelper
  def gravatar_for(user, options={size: 100})
    email_address = user.email.downcase

    # create the md5 hash
    hash = Digest::MD5.hexdigest(email_address)

    # Setting up the size of gravatar
    size = options[:size]
    # compile URL which can be used in <img src="RIGHT_HERE"...
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"


    image_tag(gravatar_url, alt: "#{user.username} Profile Image", title: "#{user.username} Photo",
              class:'rounded mx-auto d-block shadow')
  end

  # Authentication Helpers




  def logged_in?
    !!current_user # this simple method turns it to true or false
  end
end
