class BooksController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def index
    @user     = User.find(current_user.id)
    @book     = Book.new
    @book_new = Book.new
    @books    = Book.all.order(params[:sort])
  end

  def show
    @book    = Book.new
    @book_de = Book.find(params[:id])
    @user    = @book_de.user
    @book_comment = BookComment.new
    @tag = @book_de.tags
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def create
    @book = current_user.books.new(book_params)
    # @tag = Tag.new(tag_params)
    
    # if @book.save && @tag.save
      # @tag_relation = @book.tag_relationships.new(tag_id: @tag.id)
      # @tag_relation.save
    tags = params[:book][:name].split(',')
    
    if @book.save
      @book.save_tags(tags)
      byebug
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
