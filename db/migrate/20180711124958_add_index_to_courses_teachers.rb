class AddIndexToCoursesTeachers < ActiveRecord::Migration[5.2]
  def change
    add_index :courses_teachers, [:course_id, :teacher_id], unique: true
  end
end
