class Activity < ApplicationRecord
  # associations
  has_many :users, through: :user_activity
  has_many :schedules
  has_many :confirms

  # validations
  validates :name, presence: true

  # callbacks
  before_save :capitalise_name

  private

  def capitalise_name
    self.name = name.split(" ").map(&:capitalize).join(" ")
  end
end
