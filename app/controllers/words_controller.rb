class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    params[:search] ||= ""
    params[:word_filter] ||= Settings.word_filter[:all]
    @categories = Category.all
    @words = Word.includes(:answers).in_category(params[:category_id])
      .send(params[:word_filter], current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.category.per_word
  end
end
