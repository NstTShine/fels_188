class UsersController < ApplicationController

  def index
    @users = User.order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @user = User.find_by id: params[:id]
    if @user.nil?
       flash[:danger] = t "user_not_found"
       redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "register_success"
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :phone_number, :password,
      :password_confirmation
  end
end
