class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      login user
      render json: user, except: [:password_digest]
    else
      render json: { success: false }, status: 422
    end
  end

  def delete
    logout current_user
    render json: { success: true }, status: 200
  end
end
