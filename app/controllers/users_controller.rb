class UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :is_matching_guest_user, only: [:edit]
  
  def index
    @user  = User.find(current_user.id)
    @book  = Book.new
    @users = User.all
  end

  def show
    @user  = User.find(params[:id])
    @book  = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private
  
  def is_matching_login_user
    user = User.find(params[:id])
    
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
  
  def is_matching_guest_user
    user = User.find(params[:id])
    
    if user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
