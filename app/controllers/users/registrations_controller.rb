class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :success, :signed_up
        sign_up(resource_name, resource)
      else
        set_flash_message! :success, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
      end
      cookies.signed[:user_id] = resource.id
      redirect_to root_path, success: "Account created."
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
        format.html { redirect_to new_user_registration_path, danger: resource.errors.full_messages }
        format.js { @errors = resource.errors.messages.to_json }
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :email, :password, :password_confirmation,
      :name, :age, :city, :state, :country
    )
  end

end