class Article < ApplicationRecord
  validates :title,:description, presence: true
  belongs_to :user
  belongs_to :category
  has_many :article_comments, dependent: :destroy
  has_many_attached :files

  scope :search,->(s){Article.joins(:category).where("title LIKE ? OR description LIKE ? OR name LIKE ? ","%#{s}%","%#{s}%","%#{s}%") }
  
end
