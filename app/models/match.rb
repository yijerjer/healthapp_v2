class Match < ApplicationRecord
  # associations
  belongs_to :schedule1, class_name: "Schedule", foreign_key: :schedule1_id
  belongs_to :schedule2, class_name: "Schedule", foreign_key: :schedule2_id

  # validations
  validates :schedule1_id, :schedule2_id, presence: true
  validate :unique_schedule_ids

  private

  def unique_schedule_ids
    same_match_present = Match.find_by_schedule1_id_and_schedule2_id(self.schedule1_id && self.schedule2_id) || Match.find_by_schedule1_id_and_schedule2_id(self.schedule2_id && self.schedule1_id)

    if same_match_present
      errors.add(schedule1_id: "Match already created.")
    end
  end
end