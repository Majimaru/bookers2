class UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
  end
  
  private
  
  def is_matching_login_user
    user = User.find(params[:id])
    
    unless user.id == current_user.id
      redirect_to user_path(user)
    end
  end
  
end
