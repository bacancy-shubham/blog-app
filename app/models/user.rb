class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :article
  has_many :catogery, through: :user_catogery
  enum gender: [:male, :female]
  enum role: [:admin, :user]
end
