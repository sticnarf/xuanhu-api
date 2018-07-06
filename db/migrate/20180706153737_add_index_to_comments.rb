class AddIndexToComments < ActiveRecord::Migration[5.2]
  def change
    add_index :comments, [:course_id, :content, :parent_id], unique: true
  end
end
