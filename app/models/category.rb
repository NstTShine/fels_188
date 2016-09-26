class Category < ApplicationRecord
  validates :name, presence: true

  has_many :lessons
  has_many :words
end
