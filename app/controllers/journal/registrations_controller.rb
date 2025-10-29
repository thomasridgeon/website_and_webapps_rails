class Journal::RegistrationsController < ApplicationController
  # GET /journal/signup
  def new
    render html: Signup.new(controller: self, error_message: nil).to_html.html_safe
  end

  # POST /journal/signup

  # 1. check user limit
  def create
    if User.count >= 1 # User capital U- this is the class itself. I use this when calling class methods like User.count or User.find
      @error_message = "Sorry, we're not accepting any new signups at the moment"
      render html: Signup.new(controller: self, error_message: @error_message).to_html.html_safe
      return
    end

    # 2. create new user instance
    @user = User.new(username: params[:username], password: params[:password])
    @user.salt = SecureRandom.hex(16) # @user- @ is for an instance variable, accessible in the view (in my case, my Erector Widget), or elsewhere in the controller

    # 3. save user and handle session
    if @user.save
      # store user in session
      session[:user_id] = @user.id
      session[:derived_key] = Base64.encode64(@user.derive_key(params[:password], @user.salt))
      redirect_to "/journal/notes"
    else
      render plain: "Signup failed"
    end
  end
end
