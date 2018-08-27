class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :authorize_user, only: [:edit, :update]
  before_action :load_user, only: [:show, :edit, :update]

  def index
    @users = User.order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @activity = Activity.where(user_id: @user.id).order(created_at: :desc).
      paginate page: params[:page]
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

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :phone_number, :password,
      :password_confirmation
  end
end
