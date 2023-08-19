class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
  
  # def get_common_params
  #   @user = User.find(params[:id])
  #   @book = Book.new
  # end
  
end
