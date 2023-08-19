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
    @book = Book.find(params[:id])
  end
  
  def create
    book = current_user.books.new(book_params)
    if book.save
      redirect_to book_path(book)
    end
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book)
  end
  
  def destroy
    Book.find(params[:id]).destroy
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
