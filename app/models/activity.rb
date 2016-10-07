class Activity < ApplicationRecord
  belongs_to :user

  enum activity_types: [:follow, :unfollow, :create_lesson, :finished]

end
