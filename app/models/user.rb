class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :articles
  has_many :article_comments
  has_many :user_categories
  has_many :categories, through: :user_categories
  has_many :likes, dependent: :destroy
  enum gender: [:male, :female]
  enum role: [:admin, :user]

end
