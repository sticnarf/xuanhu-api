class ChangeAddJoinTableForTeacherAndCourses < ActiveRecord::Migration[5.2]
  def change
    drop_table :teachers_courses
    create_join_table :teachers, :courses
  end
end
