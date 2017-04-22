class Users::SessionsController < Devise::SessionsController
  def create
    resource = User.find_by(email: sign_in_params[:email])

    if resource && resource.valid_password?(sign_in_params[:password])
      sign_in(resource)
      redirect_to root_path
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, danger: "Incorrect email or password" }
        format.js
      end
    end
  end

end