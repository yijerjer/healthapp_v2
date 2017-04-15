class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.where(user_id: current_user.id)
  end

  def new
    @schdeule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.add_user_location if @schedule.use_user_location

    if @schedule.save
      @schedule.waiting_for_matches!
      redirect_to show_schedule_path(@schedule.id), success: "Created new schedule."
    else
      redirect_to new_schedule_path, danger: "Unable to create new schedule."
    end
  end

  def show
    @schdeule = Schedule.find_by_id(params[:id])
  end

  def destroy
    @schedule = Schedul.find_by_id(params[:id])
    @schedule.destroy
  end

  private

  def schedule_params
    params.require(:schedule).permit(:city, :state, :country, :use_user_location, :activity_id, :time)
  end

end
