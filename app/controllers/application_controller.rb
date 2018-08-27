class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def authorize_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user.current_user? @user
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "login_require"
      redirect_to login_url
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "user_not_found"
      redirect_to root_path
    end
  end

  def check_admin
      redirect_to root_path unless current_user.is_admin?
  end
end
