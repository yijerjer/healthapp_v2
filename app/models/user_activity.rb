class UserActivity < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :activity

  # validations
  validates :user_id, uniqueness: { scope: :activity_id }
  validates :activity_id, :user_id, :ability, presence: true

  #enums
  enum ability: [:new_to_sport, :amateur, :experienced, :pro]
end
