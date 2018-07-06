class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :user_id, index: true
      t.integer :comment_id, index: true
      t.integer :value

      t.timestamps
    end
  end
end
