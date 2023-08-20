class BooksController < ApplicationController
  
  def index
    @user     = User.find(current_user.id)
    @book     = Book.new
    @book_new = Book.new
    @books    = Book.all
  end

  def show
    @book    = Book.new
    @book_de = Book.find(params[:id])
    @user    = @book_de.user
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def create
    @book = current_user.books.new(book_params)
    
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = User.find(current_user.id)
      @book_new = Book.new
      @books = Book.all
      render :index
    end
  end
  
  def update
    @book = Book.find(params[:id])
    
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
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
