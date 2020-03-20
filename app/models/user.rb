# frozen_string_literal: true

class User < ApplicationRecord

  attr_accessor :login_social
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable,                 :omniauth_providers => [:facebook]
  validates :name, presence: true, uniqueness: true, unless: :login_social  
  validates :number, presence: true, length: { is: 10 }, unless: :login_social
  validates :gender, presence: true, unless: :login_social 
  validates :role, presence: true, unless: :login_social
  validates :category_ids, presence: { message: 'select any one category' }, unless: :login_social
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

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.skip_confirmation!
      user.login_social = true

    end
  end
end
