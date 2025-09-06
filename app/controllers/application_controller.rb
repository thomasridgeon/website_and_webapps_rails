class ApplicationController < ActionController::Base
  # Makes these methods accessible in views
  helper_method :current_user

  # --- Current logged-in user ---
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # --- Key derivation for notes encryption ---
  def derive_key(password, salt)
    OpenSSL::PKCS5.pbkdf2_hmac(
      password,
      salt,
      200_000, # iterations
      32,      # key length in bytes
      "sha256" # hash algorithm
    )
  end

  # --- Require login before certain actions (optional) ---
  def authenticate_user!
    redirect_to journal_login_path, alert: "Please log in" unless current_user
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
