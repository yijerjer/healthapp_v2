class Match < ApplicationRecord
  # associations
  belongs_to :schedule1, class_name: "Schedule", foreign_key: :schedule1_id
  belongs_to :schedule2, class_name: "Schedule", foreign_key: :schedule2_id
  has_one :confirm

  # validations
  validates :schedule1_id, :schedule2_id, presence: true
  validate :unique_schedule_ids

  # scope
  scope :matches_of_user, -> (user) {
    joins(:schedule1, :schedule2).where("schedules.user_id = :id OR schedule2s_matches.user_id = :id", id: user.id)
  }

  def schedules
    Schedule.where(id: [self.schedule1_id, self.schedule2_id])
  end

  def users
    User.where(id: self.schedules.pluck(:user_id))
  end

  def user1
    self.schedule1.user
  end

  def user2
    self.schedule1.user
  end

  def other_user(user)
    self.users.reject { |u| u == user }[0]
  end

  def get_user_schedule(user)
    if self.users.include?(user)
      self.schedule1.user_id == user.id ? schedule1 : schedule2
    else
      nil
    end
  end

  private

  def unique_schedule_ids
    same_match_present = Match.find_by_schedule1_id_and_schedule2_id(self.schedule1_id, self.schedule2_id) || Match.find_by_schedule1_id_and_schedule2_id(self.schedule2_id,  self.schedule1_id)

    if same_match_present
      errors.add(schedule1_id: "Match already created.")
    end
  end
end
