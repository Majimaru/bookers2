class SearchesController < ApplicationController
  
  def search
    @model = params[:model]
    @word  = params[:word]
    
    if @model == "User"
      @users = User.search_for(params[:word], params[:method])
    else
      @books = Book.search_for(params[:word], params[:method])
    end
  end
end
