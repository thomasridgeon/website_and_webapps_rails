class Journal::SessionsController < ApplicationController
  # GET /journal/login
  def new
    render html: Login.new(controller: self).to_html.html_safe
  end

  # POST /journal/login
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      session[:derived_key] = Base64.encode64(derive_key(params[:password]))
      redirect "/journal/notes"
    else
      render plain: "Login failed"
    end
  end

  # DELETE /journal/logout
  def destroy
    session[:user_id] = nil
    session[:derived_key] = nil
    redirect "/journal/login"
  end
end
