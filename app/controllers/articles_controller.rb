class ArticlesController < ApplicationController
    before_action :authenticate_user!, only: %i[create edit update destroy user_articles]
    #http_basic_authenticate_with name: "nish", password: "pass", except: [:index, :show] 
    
    def index
        @articles = Article.all.paginate(page: params[:page], per_page: 4)
        puts session[:user_id]
    end

    def new
        @article = Article.new
    end

    def user_articles
        @data_list = Article.where(:user_id => current_user.id).paginate(page: params[:page], per_page: 4)
        render 'myarticles'
    end

    def create
        @article = Article.new(article_params.merge(user_id: current_user.id))
        if @article.save
            flash[:notice] = "#{@article.title} Has Been Added"
            redirect_to :controller => "home", :action => "index"
        else
            render 'new'
        end
    end

    def show
        begin
            @article = Article.find(params[:id])  # 6
        rescue Exception => e
            # flash[:notice] = "Data not found"
            #redirect_to :controller => "home", :action => 'index'
            render :file => "#{RAILS_ROOT}/public/404.html",  :status => 404
        end     
    end

    def edit
        begin
            @article = Article.find(params[:id]) 
        rescue Exception => e
            flash[:notice] = "Post with ID #{params[:id]} Not Found"
            redirect_to :controller => "home", :action => "index"
        end   
    end

    def update
        begin
            @article = Article.find(params[:id]) 
            if @article.update(article_params)
                flash[:notice] = "Article Updated Successfully"
                redirect_to @article
            else
                flash[:notice] = "Data Couldn't be saved"
                redirect_to :controller => "home", :action => "index"            
            end
        rescue Exception => e
            flash[:notice] = "Post with ID #{params[:id]} Not Found"
            redirect_to :controller => "home", :action => "index"
        end  
    end

    def destroy
        begin
            @article = Article.find(params[:id]) 
            @article.destroy
            flash[:notice] = "Article Was Deleted successfully"
            redirect_to :controller => "home", :action => "index"
        rescue Exception => e
            flash[:notice] = "Couldn't Delete the post"
            redirect_to :controller => "home", :action => "index"
        end   
    end


    private
        def article_params
            params.require(:article).permit(:title, :subtitle, :description, :read)
        end
end
