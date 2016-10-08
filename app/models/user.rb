class User < ApplicationRecord
  include ActivitiesHelper

  validates :name, presence: true, length:{maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length:{maximum:255},
    format:{with: VALID_EMAIL_REGEX},
    uniqueness:{case_sensitive: false}
  validates :phone_number, length:{maximum: 15}

  has_many :lessons, dependent: :destroy

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :following_id, dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :activities

  has_secure_password
  validates :password, presence: true, length:{minimum: 6}

  scope :search, ->(keyword) { where("name LIKE ?", "%#{keyword}%") }

  def current_user? user
    self == user
  end
end
