class CommentsController < ApplicationController
   before_action :set_article
  def create
    @comments = @article.article_comments.new(comment_param)
    @comments.user = current_user
    @comments.save!
    redirect_to article_path(@article)
  end 

  def destroy
    @comments = @article.article_comments.find(params[:id])
    @comments.destroy
    flash[:notice] = "comment as successfully deleted"
    redirect_to article_path(@article)

  end

    private
      def set_article
          @article = Article.find(params[:article_id])
      end
      def comment_param
        params.require(:article_comment).permit(:comment)
      end
end
