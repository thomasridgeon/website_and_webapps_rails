class Blog::SessionsController < ApplicationController
  def new
    render Blog::Sessions::New.new
  end

  def create
    user = BlogUser.find_by(username: params[:username])
    if user&.authenticate(params[:password]) && user.admin?
      session[:blog_user_id] = user.id
      redirect_to blog_admin_posts_path, notice: "Logged in"
    else
      flash.now[:alert] = "Invalid credentials"
      render Blog::Sessions::New.new
    end
  end

  def destroy
    reset_session
    redirect_to blog_login_path, notice: "Logged out"
  end
end
