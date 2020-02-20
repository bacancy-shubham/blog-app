class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comments = @article.article_comments.new(comment_param)
    @comments.user = current_user
    @comments.save!
    redirect_to article_path(@article)
  end 

    private
      def comment_param
        params.require(:article_comment).permit(:comment)
      end
end
