class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authourise_user
  before_action :get_user
  skip_before_action :authenticate_user!, only: [:Iadd_password, :create_password]
  skip_before_action :authourise_user, only: [:index, :show]
  skip_before_action :get_user, only: [:index]

  def index
  end

  def show
  end

  def add_password
  end

  def create_password
    @user.signup_option = "omniauth"
    
    if @user.update(password_params)
      bypass_sign_in(@user)
      redirect_to authenticated_user_root_path, success: "Created password."
    else
      byebug
      redirect_to :back, danger: "Failed to create password"
    end
  end

  def edit
  end

  def update
    if user_update_params[:current_password].present?
      if @user.update(user_update_params)
        bypass_sign_in(@user)
        redirect_to user_path(@user), success: "Update successful"
      else
        p @user.errors.messages
        redirect_to edit_user_path(@user), danger: "Unable to update password."
      end
    else
      if @user.update_without_password(user_update_params)
        redirect_to user_path(@user), success: "Update successful"
      else
        redirect_to edit_user_path(@user), danger: "Unable to update user."
      end
    end
  end

  def destroy
  end

  private

  def authourise_user
    if params[:id] != current_user.id
      return redirect_to root_path, danger: "Unauthourised action."
    end
  end

  def check_password_exists
    if current_user
  end

  def get_user
    @user = User.find(params[:id])
  end

  def user_update_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :current_password,
      :name, :age, :city, :state, :country
    )
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
