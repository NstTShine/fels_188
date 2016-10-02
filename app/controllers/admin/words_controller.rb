class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :load_word, only: [:edit, :update, :destroy]

  def show
  end

  def index
    params[:search] ||= ""
    params[:word_filter] ||= Settings.word_filter[:all]
    @categories = Category.all
    @words = Word.includes(:answers).in_category(params[:category_id])
      .send(params[:word_filter], current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.category.per_word
  end

  def destroy
    if @word.verify_used_word
      flash[:danger] = t "word_can_not_delete"
    elsif @word.destroy
      flash[:success] = t "word_deleted"
    else
      flash[:danger] = t "word_delete_fail"
    end
    redirect_to admin_words_url
  end

  private

  def load_word
    @word = Word.find_by id: params[:id]
    if @word.nil?
      flash[:danger] = t "word_not_found"
      redirect_to root_url
    end
  end

end
