class Category < ApplicationRecord
  has_many :user_category
  has_many :user, through: :user_category
end
