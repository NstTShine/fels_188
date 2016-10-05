class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :results,
    reject_if: proc {|attributes| attributes[:word_id, :answer_id].blank?},
    allow_destroy: true
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
end
