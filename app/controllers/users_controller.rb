class UsersController < ApplicationController
  def create
    user = User.new(
      email: params[:email],
      name: params[:name],
      password: params[:password],
      is_teacher: false
    )
    if user.save
      login user
      render json: user, except: [:password_digest]
    else
      render json: user.errors
    end
  end

  def current
    if current_user
      render json: current_user, except: [:password_digest]
    else
      render json: {}, status: 401
    end
  end
end
