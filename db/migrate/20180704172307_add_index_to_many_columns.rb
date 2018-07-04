class AddIndexToManyColumns < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true
    add_index :sessions, :token, unique: true
    add_index :comments, :user_id
    add_index :comments, :course_id
  end
end
