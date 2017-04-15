class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger 

  def check_user_attributes_exist
    if !current_user.encrypted_password.present?
      return redirect_to add_password_user_path(current_user), danger: "You need a password to proceed"
    elsif !current_user.attributes_exists?
      return redirect_to edit_user_path(current_user), danger: "Missing user details"
    end 
  end
end
