class Article < ApplicationRecord
  validates :title,:description, presence: true
  belongs_to :user
  has_many :article_comment
end
