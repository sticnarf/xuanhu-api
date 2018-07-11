class Course < ApplicationRecord
  include PgSearch
  belongs_to :department
  has_and_belongs_to_many :teachers
  has_many :comments
  multisearchable :against => [:title, :course_type, :teachers_name]
  pg_search_scope :search_course, :against => [:title, :course_type], :associated_against => {
    :teachers => [:name]
  }, :using => {:tsearch => {:dictionary => "testzhcfg"}}
  # }, :using => {:trigram => {:threshold => 0.2}}

  def teachers_name
    teachers.map { |t| t.name }
  end

  # def as_json(options={})
  #   super(include: [:teachers, :department])
  # end
end
