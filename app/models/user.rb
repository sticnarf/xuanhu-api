class User < ApplicationRecord
  has_secure_password
  has_many :sessions
  has_many :comments
  has_many :votes
  belongs_to :teacher, optional: true

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :name, presence: true

  # def as_json(options={})
  #  super(except: [:password_digest, :created_at, :updated_at])
  # end
end
