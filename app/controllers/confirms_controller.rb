class ConfirmsController < ApplicationController
  before_action :authenticate_user!, :check_user_attributes_exist
  before_action :authourise_user, only: [:accept, :decline]

  def create
    @confirm = Confirm.new(confirm_params)
    @confirm.match_id = params[:match_id]

    if @confirm.save
      redirect_to match_path(params[:match_id]), success: "Created confirm. Waiting for #{@confirm.other_user(current_user)} to reply."
    else
      redirect_to match_path(params[:match_id]), danger: "Unable to create confirm."
    end
  end

  def accept
    if current_user == user1
      @confirm.update(user1_id: current_user.id)
    elsif current_user == user2
      @confirm.update(user2_id: current_user.id)
    end
  end

  def decline
    @confirm.destroy
  end

  private

  def authourise_user
    @confirm = Confirm.find_by_id(params[:id])

    unless @confirm.users.include?(current_user) && @confirm.match == params[:match_id])
      return redirect_to root_path
    end
  end

  def confirm_params
    params.require(:confirm).permit(:activity_id, :date, :time, :street, :city, :state, :country)
  end
end
