module ArticlesServices
  module_function
  def search(current_user)
    article1 = Article.all.order('category_id ASC')
    article2 = Article.joins('LEFT OUTER JOIN "user_categories" ON "user_categories"."category_id"
     = "articles"."category_id"').where('user_categories.user_id = ?', current_user).
     order('user_categories.category_id ASC')
    return articles = (article2 + article1).uniq
  end

  def article_status(current_user, param_article)
    @article = if current_user.role == 'admin'
                 current_user.articles.build(param_article.merge(status: 'accept'))
               else
                 current_user.articles.build(param_article.merge(status: 'pending'))
               end
    return @article
  end
  
end