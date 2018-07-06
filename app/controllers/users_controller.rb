class UsersController < ApplicationController
  before_action :require_login, only: [:current]

  def create
    user = User.new(
      email: params[:email].downcase,
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

  def update
    
  end

  def current
    render json: current_user, except: [:password_digest]
  end
end
