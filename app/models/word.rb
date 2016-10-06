class Word < ApplicationRecord
  validates :content, presence: true

  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  QUERY_LEARNED = "content like :search and id in (select word_id
    FROM results r INNER JOIN lessons l
    ON r.lesson_id = l.id AND l.user_id = :user_id)"
  QUERY_NOT_LEARNED = "content like :search and id not in (select word_id
    FROM results r INNER JOIN lessons l
    ON r.lesson_id = l.id AND l.user_id = :user_id)"

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}
  after_initialize :build_word_answers

  scope :random_words, -> {order("RANDOM()")}

  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  scope :show_all, -> user_id, keyword{
    where("content LIKE ? ", "%#{keyword}%")
  }
  scope :learned, -> user_id, search{
    where QUERY_LEARNED, user_id: user_id, search: "%#{search}%"
  }
  scope :not_learned, -> user_id, search{
    where QUERY_NOT_LEARNED, user_id: user_id, search: "%#{search}%"
  }
  scope :search, -> keyword, category_id{
    where "content LIKE ? OR category_id = ?", "%#{keyword}%", "#{category_id}"
  }
  scope :search_category, -> category_id = 0{
    where "category_id is null OR category_id = ?", "#{category_id}"
  }
  scope :filter_category, -> category_id = 0{
    where "category_id = ?", "#{category_id}"
  }

  validate :validate_answer

  def verify_used_word
    if self.results.any?
      errors.add "Used_word: ", I18n.t("word_can_not_delete")
    end
  end

  def validate_answer
    size_correct = self.answers.select{|answer| answer.is_correct}.size
    if size_correct != 1
      errors.add "correct_answer: ", I18n.t("number_corecct_answer")
    end
    correct_answer_size = self.answers.size
    if correct_answer_size < Settings.admin.words.answer_min_size
      errors.add "answer_size: ", I18n.t("min_number_answers")
    elsif correct_answer_size > Settings.admin.words.answer_max_size
      errors.add "answer_size: ", I18n.t("max_number_answers")
    end
  end

  private
  def build_word_answers
    if self.new_record? && self.answers.size == 0
      Settings.admin.words.default_size_word_answers.times {self.answers.build}
    end
  end
end
