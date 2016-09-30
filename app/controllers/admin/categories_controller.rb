class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :edit]
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.order(created_at: :desc)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category_add_success"
      redirect_to admin_categories_path
    else
      render :new
      flash[:danger] = t "category_add_fail"
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_category_success"
      redirect_to admin_categories_path
    else
      flash[:success] = t "update_category_fail"
      render :edit
    end
  end

  def destroy
    if @category.verify_destroy_category
      flash[:danger] = t "can_not_delete_category"
    elsif @category.destroy
      flash[:success] = t "category_deleted"
    else
      flash[:danger] = t "category_delete_fail"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "category_not_found"
      redirect_to root_url
    end
  end
end
