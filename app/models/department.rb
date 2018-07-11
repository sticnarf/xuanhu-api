class Department < ApplicationRecord
  has_many :courses
  has_many :teachers

  def as_json(options={})
    super(except: [:created_at, :updated_at])
  end
end
