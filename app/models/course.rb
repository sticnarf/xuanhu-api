class Course < ApplicationRecord
  belongs_to :department
  has_and_belongs_to_many :teachers
  has_many :comments

  def as_json(options={})
    super(include: [:teachers])
  end
end
