class UsersController < ApplicationController
  before_action :require_login, only: [:current]
  before_action :require_self, only: [:update]

  def create
    user_params = params.permit(:email, :name, :password)
    user = User.new(user_params)
    if user.save
      login user
      render json: user, except: [:password_digest]
    else
      render json: user.errors, status: 422
    end
  end

  def update
    user_params = params.permit(:name, :avatar_url)
    if current_user.update_attributes(user_params)
      render json: current_user, except: [:password_digest]
    else
      render json: current_user.errors, status: 422
    end
  end

  def current
    render json: current_user, except: [:password_digest]
  end

  private
  def require_self
    if current_user&.id&.to_s != params[:id]
      render json: { success: false }, status: 403
    end
  end
end
