class SwitchForeignKeyBetweenUserAndTeacher < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :teacher_id, :integer, index: true
    remove_column :teachers, :user_id
  end
end
