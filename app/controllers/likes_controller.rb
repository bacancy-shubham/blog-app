# frozen_string_literal: true
#article or comment like
class LikesController < ApplicationController
  before_action :find_post, except: [:destroy]
  # before_action :find_like, only: [:destroy]

  def create
    if params[:type] == 'Comment'
      @article.likes.create(user_id: current_user.id, article_id: @article.article_id)
    else
      @article.likes.create(user_id: current_user.id, article_id: @article.id)
    end
    flash[:notice] = 'like is added'
    redirect_to article_path(params[:article_id])
  end

  def destroy
    Like.find(params[:id]).destroy
    flash[:notice] = 'dislike is successfully'
    redirect_to article_path(params[:article_id])
  end

  def already_liked
    Like.where(user_id: current_user.id, likeable_id:
    params[:article_id]).exists?
  end

  private

  def find_post
    @article = if params[:type] == 'Comment'
                 ArticleComment.find(params[:id])
               else
                 Article.find(params[:article_id])
               end
  end

  # def find_like
  #   @like = @article.likes.find_by(params[:id])
  # end
end
