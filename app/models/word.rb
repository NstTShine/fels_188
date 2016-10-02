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

  def verify_used_word
    if self.results.any?
      errors.add "Used_word:", I18n.t("word_can_not_delete")
    end
  end
end
