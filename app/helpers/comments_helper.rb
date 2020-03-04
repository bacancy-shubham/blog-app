module CommentsHelper

  def is_liked? comment    
    article_comments.likes.find_by(user: current_user)
  end
end
