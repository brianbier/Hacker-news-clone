class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true, length: { minimum: 6}
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validate :start_with_letter_l
  validate :email_validator
  has_secure_password
  has_many :posts
  has_many :comments

  private 

  def start_with_letter_l
    if user_name && !user_name.downcase.start_with?("l")

      errors.add(:user_name, 'did not start with lowercase l')
    end
  end


  def email_validator
    unless email && email.match(/[^!@#$%^&*()~]+[^!@#$%^&*()~0.9]+.com/)
      errors.add(:email, 'is not valid')
    end
  end


end
