class SearchesController < ApplicationController
  def search
    @model    = params[:model]
    @content  = params[:content]
    @method   = params[:method]

    if @model == "User"
      @records = User.search_for(@content, @method)
    elsif @model == "Book"
      @records = Book.search_for(@content, @method)
    elsif @model == "Tag"
      @records = Tag.search_for(@content, @method)
    end
  end
end
