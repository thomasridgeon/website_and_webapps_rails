class Journal::RegistrationsController < ApplicationController
  # GET /journal/signup
  def new
    render html: Signup.new(controller: self).to_html.html_safe
  end

  # POST /journal/signup
  def create
    user = User.new(username: params[:username], password: params[:password])
    user.salt = SecureRandom.hex(16)
    if user.save
      # store user in session
      session[:user_id] = user.id
      session[:derived_key] = Base64.encode64(user.derive_key(params[:password], user.salt))
      redirect_to "/journal/notes"
    else
      render plain: "Signup failed"
    end
  end
end
