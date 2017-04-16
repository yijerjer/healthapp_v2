class ScheduleResponse < ApplicationRecord
  # enums
  enum status: [:accepted, :declined]

  # validations
  validates :responder_id, :receiver_id, :status, presence: true
  validates :responder_id, uniqueness: { scope: :receiver_id }

  # associations
  belongs_to :responder, class_name: "Schedule", foreign_key: :responder_id
  belongs_to :receiver, class_name: "Schedule", foreign_key: :receiver_id

  def valid_responder?(user)
    return self.responder.user == user
  end

  def other_side_accepted?
    other_response = ScheduleResponse.find_by_responder_id_and_receiver_id(self.receiver_id, self.responder_id)

    if other_response && other_response.accepted?
      match = Match.create(schedule1_id: self.responder_id, schedule2_id: self.receiver_id)
      return match
    else
      return false
    end
  end
end
