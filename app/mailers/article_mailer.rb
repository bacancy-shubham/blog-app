# frozen_string_literal: true

class ArticleMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.article_mailer.new_article.subject
  #
  def new_article(article, current_user)
    @article = article
    @title = @article.title
    @adminname = current_user.name

    mail to: @article.user.email,
         subject: 'Article Accepted'
  end
end
