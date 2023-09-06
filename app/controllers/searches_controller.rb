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
  
  def tag_search
    @model = "Tag"
    @content  = params[:content]
    @tags = Tag.where(name: params[:content])
    render "search"
  end
  
end
