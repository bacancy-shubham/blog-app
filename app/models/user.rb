# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true, uniqueness: true
  validates :number, presence: true, length: { is: 10 }
  validates :gender, presence: true 
  validates :role, presence: true
  validates :category_ids, presence: { message: 'select any one category' }
  # validates :password,
  #           format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/,
  #                     message: 'Password should have more than 7 characters including 2                                uppercase letter, 1 number, 1 special character'
  #                   }

  has_many :articles
  has_many :article_comments
  has_many :user_categories
  has_many :categories, through: :user_categories
  has_many :likes, dependent: :destroy
  enum gender: %i[male female]
  enum role: %i[admin user]
end
