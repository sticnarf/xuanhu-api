class AddVotesAndParentIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :voteUp, :integer
    add_column :comments, :voteDown, :integer
    add_column :comments, :parent_id, :integer, index: true
  end
end
