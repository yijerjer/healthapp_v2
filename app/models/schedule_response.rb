class ScheduleResponse < ApplicationRecord
  # enums
  enum status: [:accepted, :declined]

  # validations
  validates :responder_id, :receiver_id, :status, presence: true
  validates :responder_id, uniqueness: { scope: :receiver_id }

  # associations
  belongs_to :responder, class_name: "Schedule", foreign_key: "responder_id"
  belongs_to :receiver, class_name: "Schedule", foreign_key: "receiver_id"

  def valid_responder?(user)
    return self.responder.user == user
  end
end
