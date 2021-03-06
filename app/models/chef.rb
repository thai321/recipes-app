class Chef < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 30 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_many :recipes, dependent: :destroy
  has_secure_password # enforce the user to sign up with password
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true # allow the password field to be empty when update

  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
end
