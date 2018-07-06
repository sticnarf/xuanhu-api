class CoursesController < ApplicationController
  def show
    course = Course.find_by(id: params[:id])
    if course
      render json: course
    else
      render json: { success: false }, status: 404
    end
  end

  def search
    courses = Course.search_course(params[:keyword])
    render json: (courses.as_json.map! do |c|
      c['teachers'].map! { |t| t['name']}
      c['department'] = c['department']['name']
      c.slice('id', 'title', 'teachers', 'course_type', 'department')
    end)
  end
end
