class AddIdToCoursesTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :courses_teachers, :id, :primary_key
  end
end
