class LessonsController < ApplicationController
  before_action :load_categories, only: :index
  before_action :load_lesson, :authorize_user_lesson, only: [:edit, :update, :show]

  def index
    @lesson = Lesson.new
    @lessons = current_user.lessons.order(created_at: :desc).
      paginate page: params[:page], per_page: Settings.per_page
  end

  def create
    @lesson = Lesson.new category_id: params[:lesson][:category_id],
      user_id: current_user.id
    if @lesson.save
      flash[:success] = t "create_succse_and_join_lesson"
      redirect_to edit_lesson_path(@lesson)
    else
      flash[:danger] = t "lesson_create_fail"
      redirect_to lessons_path
    end
  end

  def edit
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t "lesson_not_found"
    end
  end

  def authorize_user_lesson
    unless current_user.current_user? @lesson.user
      flash[:danger] =  t "authorize_user_lesson_err"
      redirect_to root_url
    end
  end

  private
  def load_categories
    @categories = Category.all
  end
end
