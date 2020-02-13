class ArticlesController < ApplicationController
  before_action :set_article, only:[:show, :destroy, :edit, :update]
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

  def destroy
      @article.destroy
      flash[:notice] = "article was successfully deleted"
      redirect_to articles_path
  end

  def edit

  end

  def update
      if @article.update(param_article)
        flash[:notice] = "artcle was successfully updated"
        redirect_to article_path(@artcle)
      else
        render 'edit'
      end
  end

  def home
      
  end

  private
  def set_article
      @article = Article.find(params[:id])
  end
  def param_article
      params.require(:article).permit(:title,:description)
  end
  
end
