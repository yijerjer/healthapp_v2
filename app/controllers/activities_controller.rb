class ActivitiesController < ApplicationController
  before_action :sanitise_params, only: [:add_to_interests]

  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find_by_id(params[:id])
  end

  def add_to_interests
    user_activity = UserActivity.new(user_activity_params)
    user_activity.user_id = current_user.id

    if user_activity.save
      redirect_to activities_path, success: "Added #{user_activity.activity.name} to favourites."
    else
      redirect_to activities_path, danger: "Unable to add to favourites."
    end
  end

  private

  def sanitise_params
    params[:user_activity][:ability] = params[:user_activity][:ability].to_i
  end

  def user_activity_params
    params.require(:user_activity).permit(:activity_id, :user_id, :ability)
  end
end
