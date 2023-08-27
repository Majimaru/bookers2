class SearchesController < ApplicationController
  
  def search
    @model = params[:model]
    @content  = params[:content]
    
    if @model == "User"
      @users = User.search_for(@content, params[:method])
    else
      @books = Book.search_for(@content, params[:method])
    end
  end
end
