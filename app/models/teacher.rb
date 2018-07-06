class Teacher < ApplicationRecord
  has_and_belongs_to_many :courses
  has_one :user
  belongs_to :department, optional: true
end
