module LikesHelper
  def is_liked? article
    article.likes.find_by(user: current_user)
  end
end
