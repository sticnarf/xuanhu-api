class RemoveIsTeacher < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_teacher
  end
end
