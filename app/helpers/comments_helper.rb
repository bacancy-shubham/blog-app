# frozen_string_literal: true

module CommentsHelper
  def is_liked?(_comment)
    article_comments.likes.find_by(user: current_user)
  end
end
