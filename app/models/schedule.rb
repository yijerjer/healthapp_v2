class Schedule < ApplicationRecord
  attr_accessor :use_user_location, :date

  # associations
  belongs_to :user
  belongs_to :activity
  has_many :responses, class_name: "ScheduleResponse", foreign_key: :responder_id
  has_many :receives, class_name: "ScheduleResponse", foreign_key: :receiver_id
  has_many :matches1, class_name: "Match", foreign_key: :schedule1_id
  has_many :matches2, class_name: "Match", foreign_key: :schedule2_id


  #validations
  validates :city, :state, :country, :time, :activity_id, :user_id, :status, presence: true

  # callbacks
  before_save :merge_date_time
  before_save :convert_country_state_code_to_names, :capitalize_city, if: :valid_city_state_country?

  # enums
  enum status: [:waiting_for_matches, :has_matches, :has_confirmed]


  def matches
    Match.where("schedule1_id = :id OR schedule2_id = :id", id: self.id)
  end
  
  def available_matches
    age_range = ((self.user.age - 5)..(self.user.age + 5)).to_a

    # filter by most attributes
    schedules = Schedule.joins(:user).where(
      activity: self.activity, status: ["waiting_for_matches", "has_matches"],
      city: self.city, state: self.state, country: self.country,
      users: {
        age: age_range
      }
    )

    # filter by date - give range of +-2
    date_range = ((self.time.to_date - 2)..(self.time.to_date + 2)).to_a
    schedules = schedules.where("date(time) IN (?)", date_range)

    # remove their own schedule
    return schedules.reject { |schedule| schedule.user_id == self.user_id }
  end

  def add_user_location(user)
    self.city = user.city
    self.state = user.state
    self.country = user.country
  end

  private

  def convert_country_state_code_to_names
    country_code = country
    self.country = CS.get[country.to_sym]
    self.state = CS.get(country_code)[state.to_sym]
  end

  def capitalize_city
    self.city = city.split(" ").map(&:capitalize).join(" ")
  end

  def valid_city_state_country?
    return CS.get[country.to_sym].present?
  end

end
