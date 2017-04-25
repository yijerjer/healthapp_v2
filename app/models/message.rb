class Message < ApplicationRecord
  # associations
  belongs_to :match
  belongs_to :user

  # validations
  validates :match_id, :user_id, :content, presence: true
  validate :user_in_match

  private

  def user_in_match
    unless match.users.include?(user)
      errors.add(:user, "is unauthorised")
    end
  end
end
