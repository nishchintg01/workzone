class HomeController < ApplicationController
  def index
    @articles = Article.all.paginate(page: params[:page], per_page: 4)
    puts session[:user_id]
  end
end
