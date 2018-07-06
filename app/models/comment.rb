class Comment < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :child_comments, class_name: 'Comment', foreign_key: :parent_id
  has_many :votes
  belongs_to :parent_comment, class_name: 'Comment', optional: true

  def parent_comment_id
    parent_id
  end

  def descendents
    self_and_descendents - [self]
  end

  def self_and_descendents
    self.class.tree_for(self)
  end

  def descendent_pictures
    subtree = self.class.tree_sql_for(self)
    Comment.where("category_id IN (#{subtree})")
  end

  def self.tree_for(instance)
    where("#{table_name}.id IN (#{tree_sql_for(instance)})").order("#{table_name}.id")
  end

  def self.tree_sql_for(instance)
    tree_sql =  <<-SQL
      WITH RECURSIVE search_tree(id, path) AS (
          SELECT id, ARRAY[id]
          FROM #{table_name}
          WHERE id = #{instance.id}
        UNION ALL
          SELECT #{table_name}.id, path || #{table_name}.id
          FROM search_tree
          JOIN #{table_name} ON #{table_name}.parent_id = search_tree.id
          WHERE NOT #{table_name}.id = ANY(path)
      )
      SELECT id FROM search_tree ORDER BY path
    SQL
  end

  def recursive_json(user_id)
    all = self_and_descendents
    all_votes = Vote.where(comment_id: { in: all.map { |c| c[:id] } })
                    .group_by { |v| v[:id] }
                    .transform_values! { |v| v.first[:value] }
    gi = all.group_by { |c| c[:id] }.transform_values! do |c|
      obj = c.first.as_json
      obj['voteValue'] = (all_votes[obj['id']] || 0)
      obj['nestedComment'] = []
      obj
    end
    all.each do |c|
      # byebug
      parent = gi[c.parent_id]
      unless parent.nil?
        parent['nestedComment'] << (gi[c.id])
      end
    end
    gi[id]
  end

  def as_json(options={})
    super(except: [:course_id, :user_id, :parent_id],
          include: [user: { except: [:password_digest]}]
    )
  end
end
