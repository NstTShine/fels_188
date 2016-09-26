class Word < ApplicationRecord
  validates :content, presence: true

  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
end
