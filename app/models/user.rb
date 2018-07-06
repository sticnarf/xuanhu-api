class User < ApplicationRecord
  has_secure_password
  has_many :sessions
  has_many :comments

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :name, presence: true

  def as_json(options={})
    super(except: [:password_digest])
  end
end
