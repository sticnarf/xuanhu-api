class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name
      t.text :intro
      t.integer :department_id
      t.integer :user_id

      t.timestamps
    end
  end
end
