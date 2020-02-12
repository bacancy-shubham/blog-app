class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  def index
      @articles = Article.all
  end

  def new
      @article = current_user.article.build
      # @article = Article.create
  end

  def create 
      @article = current_user.article.build(param_article)
      # @article = Article.create(param_article)
      if @article.save
         flash[:notice] = "Article was sucessfully created"
         redirect_to article_path(@article)
      else
        render 'new'
        flash[:notice] = "not created"
      end

  end

  def show

  end

  private
  def set_article
      @article = Article.find(params[:id])
  end
  def param_article
      params.require(:article).permit(:title,:description)
  end
  
end
