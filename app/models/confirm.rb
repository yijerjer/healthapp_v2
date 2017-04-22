class Confirm < ApplicationRecord
  attr_accessor :date

  # associations
  belongs_to :match

  #validations
  validates :match_id, :activity_id, :time, :street, :city, :state, :country, presence: true
  validates :match_id, uniqueness: true

  # callbacks
  before_save :merge_date_time


  def schedules
    Schedule.where(id: [self.match.schedule1_id, self.match.schedule2_id])
  end

  def users
    self.user1_id && self.user2_id ? User.where(id: [self.user1_id, self.user2_id]) : User.where(id: self.schedules.pluck(:user_id))
  end

  def user1
    User.find_by_id(self.match.schedule1.user_id)
  end

  def user2
    User.find_by_id(self.match.schedule2.user_id)
  end

  # get the other user of the confirm
  def other_user(user)
    self.users.reject { |u| u == user }[0]
  end

  # // get all confirms with user involved
  def self.of_user(user)
    user_id = user.id

    Confirm.joins(match: [:schedule1, :schedule2]).where(
      "schedules.user_id = :id OR schedule2s_matches.user_id = :id",
      id: user_id
    )
  end

end
