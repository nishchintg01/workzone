class CommentsController < ApplicationController
    def create
        begin
            @article = Article.find(params[:article_id])
            @comment = @article.comments.create(comment_params.merge(user_id: current_user.id))
            redirect_to article_path(@article)
        rescue Exception => e
            puts e
            redirect_to :controller => 'home', :action => 'index'
        end
    end


    def destroy
        begin
            @article = Article.find(params[:article_id])
            @comment = @article.comments.find(params[:id])
            puts "In destroy method"
            @comment.destroy
            redirect_to article_path(@article)
        rescue Exception => e
            puts e
            redirect_to :controller => 'home', :action => 'index'
        end
    end


    private

    def comment_params
        params.require(:comment).permit(:content)
    end

end
