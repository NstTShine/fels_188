class Category < ApplicationRecord
  validates :name, presence: true
  validates :desciption, length: {maximum: 300}

  has_many :lessons
  has_many :words

  private
  def verify_destroy_category
    if self.words.any? || self.lessons.any?
      errors.add "category", I18n.t("can_not_delete_category")
    end
  end
end
