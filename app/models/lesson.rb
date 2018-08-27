class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :words, through: :results
  has_many :answers, through: :results

  validate :check_words_size, on: :create
  accepts_nested_attributes_for :results

  before_create :assign_word

  def score
    "#{self.results.select{|result| result if result.is_correct}.count}/
      #{self.results.count}"
  end

  private
  def assign_word
    self.category.words.random_words.limit(Settings.words_in_each_lesson).each do |word|
      self.results.build word_id: word.id
    end
  end

  def check_words_size
    if self.category.nil? || self.category.words.size < Settings.number_word_require
      self.errors.add :category, I18n.t("word_not_enough")
    end
  end
end
