class AddTeachersCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers_courses, id: false do |t|
      t.belongs_to :teachers, index: true
      t.belongs_to :courses, index: true
    end
  end
end
