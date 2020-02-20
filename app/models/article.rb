class Article < ApplicationRecord
  validates :title,:description, presence: true
  belongs_to :user
  belongs_to :category
  has_many :article_comments
  has_many_attached :files
end
