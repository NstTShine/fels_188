class Anwser < ApplicationRecord
  validates :content, presence: true

  belongs_to :word
  has_many :results, dependent: :destroy
end
