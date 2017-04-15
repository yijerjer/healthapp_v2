class Schedule < ApplicationRecord
  attr_accessor :use_user_location, :date

  # associations
  belongs_to :user
  belongs_to :activity

  #validations
  validates :city, :state, :country, :time, :activity_id, :user_id, :status, presence: true

  # callbacks
  before_save :merge_date_time, :convert_country_state_code_to_names, :capitalize_city

  # enums
  enum status: [:waiting_for_matches, :has_matches, :has_confirms]


  def add_user_location(user)
    self.city = user.city
    self.state = user.state
    self.country = user.country
  end

  private

  def merge_date_time
    if date && time
      d = date.to_date
      t = time.to_time

      time = Time.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    end
  end

  def convert_country_state_code_to_names
    country_code = country
    self.country = CS.get[country.to_sym]
    self.state = CS.get(country_code)[state.to_sym]
  end

  def capitalize_city
    self.city = city.split(" ").map(&:capitalize).join(" ")
  end

end
