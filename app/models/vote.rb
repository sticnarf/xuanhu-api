class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  validates :value, inclusion: { in: -1..1 }
end
