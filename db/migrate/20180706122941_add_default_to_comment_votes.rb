class AddDefaultToCommentVotes < ActiveRecord::Migration[5.2]
  def change
    change_column_default :comments, :voteUp, 0
    change_column_default :comments, :voteDown, 0
  end
end
