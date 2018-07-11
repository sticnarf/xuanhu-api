class UsersController < ApplicationController
  before_action :require_login, only: [:current]
  before_action :require_self, only: [:update]

  def create
    user_params = params.permit(:email, :name, :password)
    user = User.new(user_params)
    if user.save
      login user
      my_render json: user
    else
      my_render json: user.errors, status: 422
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      my_render json: user
    else
      render json: { success: false }, status: 404
    end
  end

  def update
    user_params = params.permit(:name, :avatar_url, :description)
    if current_user.update_attributes(user_params)
      my_render json: current_user
    else
      render json: current_user.errors, status: 422
    end
  end

  def comments
    comments = Comment.where(user_id: params[:user_id], parent_id: nil).order(created_at: :desc)
    myvotes = {}
    if current_user
      myvotes = Vote.where('user_id = ? AND comment_id in (?)', current_user.id, comments.map { |c| c.id })
                  .group_by { |v| v.comment_id }
                  .transform_values! { |v| v.first.value }
    end
    render json: (comments.map do |c|
      j = c.as_json
      j[:course] = c.course
      j[:voteValue] = myvotes[c.id] || 0
      j
    end)
  end

  def votes
    votes = Vote.where(user_id: params[:user_id]).order(updated_at: :desc)
    comments = Comment.where('id in (?) AND parent_id is null', votes.map { |v| v.comment_id } )
    values = votes.group_by { |v| v.comment_id }.transform_values! { |v| v.first.value }
    render json: (comments.map do |c|
      j = c.as_json
      j[:course] = c.course
      j[:voteValue] = values[c.id] || 0
      j
    end)
  end

  def upload
    p params
  end

  def current
    my_render json: current_user
  end

  private
  def require_self
    if current_user&.id&.to_s != params[:id]
      render json: { success: false }, status: 403
    end
  end

  def my_render(options)
    render options.merge(:except => [:password_digest, :created_at, :updated_at])
  end
end
