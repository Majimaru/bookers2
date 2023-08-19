class BooksController < ApplicationController
  
  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.new
    @book_de = Book.find(params[:id])
    @user = @book_de.user
  end
  
  def edit
    
  end
  
  def create
    book = current_user.books.new(book_params)
    if book.save
      redirect_to book_path(book)
    end
  end
  
  def destroy
    
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
