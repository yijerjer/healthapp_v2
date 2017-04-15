class Schedule < ApplicationRecord
  attr_accessor :use_user_location

  # associations
  belongs_to :user
  belongs_to :activity

  #validations
  validates :city, :state, :country, :time, :activity_id, :user_id, :status, presence: true

  # enums
  enum status: [:waiting_for_matches, :has_matches, :has_confirms]

  private

  def add_user_location
    self.city = current_user.city
    self.state = current_user.state
    self.country = current_user.country
  end

end
