class Teacher < ApplicationRecord
  has_and_belongs_to_many :courses
  has_one :user
  belongs_to :department, optional: true

  def as_json(options={})
    super(except: [:created_at, :updated_at])
  end
end
