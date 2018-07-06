class ApplicationController < ActionController::API
  def login(user)
    return if current_user&.id == user.id
    token = SecureRandom.hex(32)
    Session.new(token: token, user: user).save!
    session[:user] = token
  end

  def logout(user)
    return if current_user.nil?
    Session.find_by(token: session[:user])&.delete
    token = SecureRandom.hex(32)
    session[:user] = token
  end

  def current_user
    @current_user ||= Session.find_by(token: session[:user])&.user
  end

  def require_login
    if current_user.nil?
      render json: { success: false }, status: 403
    end
  end
end
