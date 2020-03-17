# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :user_categories
  has_many :users, through: :user_categories
  has_many :articles
end
