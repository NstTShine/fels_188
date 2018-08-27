class Result < ApplicationRecord
  belongs_to :word
  belongs_to :lesson
  belongs_to :answer
  delegate :is_correct, to: :answer, allow_nil: true
end
