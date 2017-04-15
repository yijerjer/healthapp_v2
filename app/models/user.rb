class User < ApplicationRecord
  attr_accessor :current_password, :skip_password_validation, :signup_option

  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  # associations
  has_many :authentications, dependent: :destroy
  has_many :activities, through: :user_activity
  has_many :schedules, dependent: :destroy

  # validations
  validates :name, presence: true
  validates :age, :city, :state, :country, presence: true, unless: :omniauth_signup? 
  validates :age, numericality: { greater_than: 0 }, if: "age.present?"
  validate :correct_passwords_on_update, on: :update

  # callbacks
  before_update :convert_country_state_code_to_names, :capitalize_city, if: :has_city_state_country?


  def self.create_from_omniauth(authentication, auth_hash)
    avatar_url = auth_hash.info.image.gsub("http://", "https://") + "?width=1000&height=1000"

    user = User.new(
      email: auth_hash.info.email, name: auth_hash.info.name, remote_avatar_url: avatar_url,
      skip_password_validation: true, signup_option: "omniauth"
    )
    user.save
    user.authentications << authentication

    return user
  end

  private

  def correct_passwords_on_update
    if current_password.present?
      unless !self.valid_password?(current_password) || password == password_confirmation
        errors.add(:password, "needs to match")
      end
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

  def has_city_state_country?
    return city.present? && state.present? && country.present?
  end

  def password_required?
    skip_password_validation ? false : super
  end

  def omniauth_signup?
    return signup_option == "omniauth"
  end

end
