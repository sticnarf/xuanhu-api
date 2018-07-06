class AddIntroAndCourseTypeToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :intro, :text
    add_column :courses, :course_type, :string, index: true
  end
end
