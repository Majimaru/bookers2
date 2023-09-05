class BooksController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def index
    @user     = User.find(current_user.id)
    @book     = Book.new
    @book_new = Book.new
    # 新着順
    if params[:latest]
      @books = Book.all.order(created_at: :desc)
    # 評価順
    elsif params[:most_rated]
      @books = Book.all.order(star: :desc)
    else
      @books    = Book.all
    end
  end

  def show
    @book    = Book.new
    @book_de = Book.find(params[:id])
    @user    = @book_de.user
    @book_comment = BookComment.new
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
  
  def is_matching_login_user
    book = Book.find(params[:id])
    user = book.user
    
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
  
  def book_params
    params.require(:book).permit(:title, :body, :star)
  end
  
end
