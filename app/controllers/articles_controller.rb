# frozen_string_literal: true
require 'ArticlesServices'
require 'will_paginate/array'

#article methods
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show destroy edit update]
  before_action :authenticate_user!, except: %i[index home show]
  def index
    if params[:query].present?
      @articles = Article.search(params[:query]).where('status = ?', 'accept')
      respond_to do |format|
        format.js
      end
    else  
      articles = ArticlesServices.search(current_user)
      @articles = articles.paginate(per_page: 5, page: params[:page])
      @rejected_articles = Article.where('articles.user_id = ? AND articles.status = ?',
       current_user, 'reject')
    end

  end 

  def new
    @article = current_user.articles.build
    # @article = Article.create
  end

  def create
    @article = ArticlesServices.article_status(current_user, param_article)
    # @article = Article.create(param_article)
    if @article.save
      if current_user.role == 'admin'
        flash[:notice] = 'Article was successfully created'
        redirect_to article_path(@article)
      else
        flash[:notice] = 'Article is under observation'
        redirect_to articles_path
      end
    else
      render 'new'
      flash[:notice] = 'Article was not created'
    end
  end

  def show
    @comments = @article.article_comments
  end

  def destroy
    @article.destroy
    flash[:notice] = 'article was successfully deleted'
    redirect_to articles_path
  end

  def edit
    @article.update(status: 'pending') if @article.status == 'reject'
  end

  def update
    if @article.update(param_article)
      flash[:notice] = 'article was successfully updated'
      redirect_to article_path
    else
      render 'edit'
    end
  end

  def home; end

  def article_request
    @articles = Article.all.where('status = ?', 'pending')
  end

  def article_accept_request
    @article = Article.find(params[:article_id])
    @article.update(status: 'accept')
    ArticleMailer.new_article(@article, current_user).deliver_now
    flash[:notice] = 'article was  accepted'
    redirect_to request_articles_path
  end

  def article_reject_request
    @article = Article.find(params[:article_id])
    @article.update(status: 'reject')
    flash[:notice] = 'article was rejected'
    redirect_to request_articles_path
  end

  def notification
    @likes = Like.joins(:article).all.where('articles.user_id = ?', current_user).
    order('likes.created_at DESC')
    @comments = ArticleComment.joins(:article).all.where('articles.user_id = ?', current_user).
    order('article_comments.created_at DESC')
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def param_article
    params.require(:article).permit(:title, :description, :category_id, files: [])
  end
end
