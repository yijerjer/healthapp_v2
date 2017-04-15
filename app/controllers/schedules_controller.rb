class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :authourise_user, only: [:show, :destroy]
  before_action :check_user_attributes_exist

  def index
    @schedules = Schedule.where(user_id: current_user.id)
  end

  def new
    @schdeule = Schedule.new
  end

  def create
    schedule_hash = schedule_params
    schedule_hash.merge!(user_id: current_user.id, status: "waiting_for_matches")

    @schedule = Schedule.new(schedule_hash)
    @schedule.add_user_location(current_user) if @schedule.use_user_location == "1"

    if @schedule.save
      redirect_to schedule_path(@schedule.id), success: "Created new schedule."
    else
      redirect_to new_schedule_path, danger: "Unable to create new schedule."
    end
  end

  def show
    @schdeule = Schedule.find_by_id(params[:id])
  end

  def destroy
    @schedule = Schedule.find_by_id(params[:id])
    @schedule.destroy
  end

  private

  def authourise_user
    if Schedule.find_by_id(params[:id]).user_id != current_user.id
      return redirect_to :back, danger: "Unauthourised action."
    end
  end

  def schedule_params
    params.require(:schedule).permit(:city, :state, :country, :use_user_location, :activity_id, :date, :time)
  end

end
