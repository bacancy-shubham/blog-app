class ArticleComment < ApplicationRecord
  validates :comment, presence: true
  belongs_to :user
  belongs_to :article
end
