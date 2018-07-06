class CoursesController < ApplicationController
  def show
    course = Course.find_by(id: params[:id])
    if course
      render json: course
    else
      render json: { success: false }, status: 404
    end
  end
end
