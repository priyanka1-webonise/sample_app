class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  EMAIL_REGEX = EMAIL_REGEX = /[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)/i

  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :registerable

  validates :name, presence: true, length: {maximum: 45, allow_blank: true}
  validates :email,
            presence: { message: 'Please enter an email address' },
            format: { allow_blank: true,
            with: EMAIL_REGEX,
            message: 'Please enter a valid email address' }
  validates :password, presence: { message: 'Please enter password' }
  validates :password_confirmation, presence: { message: 'Please re-enter password' }
end
