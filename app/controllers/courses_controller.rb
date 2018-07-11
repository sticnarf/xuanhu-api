class CoursesController < ApplicationController
  def index
    courses = Course.all
    render json: courses.map { |c| c.title }
  end

  def show
    course = Course.find_by(id: params[:id])
    if course
      render json: course, include: [:teachers, :department]
    else
      render json: { success: false }, status: 404
    end
  end

  def search
    courses = Course.search_course(params[:keyword])
    render json: (courses.as_json(include: [:teachers, :department]).map! do |c|
      c['teachers'].map! { |t| t['name']}
      c['department'] = c['department']['name']
      c.slice('id', 'title', 'teachers', 'course_type', 'department', 'intro')
    end)
  end

  def teachers
    p params
    course = Course.find_by(id: params[:course_id])
    teachers = Teacher.where('name in (?)', params[:names])
    course.teachers = teachers
    if course.save
      render json: course
    else
      render json: { success: false }, status: 422
    end
  end
end
