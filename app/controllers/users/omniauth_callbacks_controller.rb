class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash.provider, auth_hash.uid) || Authentication.create_from_omniauth(auth_hash)

    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      flash_message = "Sign in successful."
      redirect_path = authenticated_user_root_path
    else
      user = User.create_from_omniauth(authentication, auth_hash)
      flash_message = "Sign up successful. Please add create a password for your account."
      redirect_path = add_password_user_path(user)
    end

    sign_in(user, scope: :user)
    cookies.signed[:user_id] = user.id
    redirect_to redirect_path, success: flash_message
    
  end

  def failure
    redirect_to root_path
  end
end