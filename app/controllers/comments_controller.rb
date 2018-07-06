class CommentsController < ApplicationController
  before_action :require_login, only: [:create, :vote]

  def create
    comment_params = params.permit(:course_id, :content, :parent_id)
    comment = Comment.new(comment_params)
    comment.user = current_user
    if comment.save
      render json: comment
    else
      render json: comment.errors, status: 422
    end
  end

  def index
    root = Comment.where(course_id: params[:course_id], parent_id: nil)
    render json: root.map { |c| c.recursive_json(current_user&.id) }
  end

  def vote
    comment = Comment.find_by(id: params[:comment_id])
    v = Vote.find_by(user_id: current_user.id, comment_id: params[:comment_id])
    up = ((params[:value] == 1) ? 1 : 0)
    down = ((params[:value] == -1) ? 1 : 0)
    if v.nil?
      v = Vote.new(user_id: current_user.id, comment_id: comment.id, value: params[:value])
    else
      old_up = ((v.value == 1) ? 1 : 0)
      old_down = ((v.value == -1) ? 1 : 0)
      up = up - old_up
      down = down - old_down
      v.value = params[:value]
    end
    status = comment.transaction do
      v.save && comment.update_attributes(
        voteUp: comment.voteUp + up,
        voteDown: comment.voteDown + down
      )
    end
    if status
      render json: comment
    else
      render json: { success: false }, status: 422
    end
  end
end
