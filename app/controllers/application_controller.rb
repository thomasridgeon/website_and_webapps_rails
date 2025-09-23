class ApplicationController < ActionController::Base
  # ======================
  # ---Blog---------------
  # ======================
  helper_method :current_blog_user
  # Even though I'm the only admin user, we still need to know “Am I logged in?” and “Who am I?” for each request. So:
  def current_blog_user
    return unless session [ :blog_user_id ]
    @current_blog_user ||= BlogUser.find_by(id: session[:blog_user_id]) # ||= means if @current_blog_user, then it's @current_blog_user. If not, then run the query on the right.
  end

  def authenticate_blog_admin!
    unless current_blog_user&.admin?
      redirect_to blog_login_path, alert: "Admins only"
    end
  end

  # ======================
  # --- Journal ----------
  # ======================
  # Makes these methods accessible in views
  helper_method :current_user

  # --- Current logged-in user ---
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # --- Require login before certain actions (optional) ---
  def authenticate_user!
    redirect_to journal_login_path, alert: "Please log in" unless current_user
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
