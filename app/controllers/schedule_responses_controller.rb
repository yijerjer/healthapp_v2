class ScheduleResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_attributes_exist

  def accept
    @schedule_response = ScheduleResponse.new(schedule_response_params)
    @schedule_response.receiver_id = params[:id]
    @schedule_response.accepted!

    if @schedule_response.valid_responder?(current_user) && @schedule_response.save
      redirect_to schedule_path(@schedule_response.responder), success: "Responded to #{@schedule_response.receiver.user.name}'s schedule"
    else
      redirect_to schedule_path(@schedule_response.responder), danger: "Unable to respond."
    end
  end

  def decline
    @schedule_response = ScheduleResponse.new(schedule_response_params)
    @schedule_response.receiver_id = params[:id]
    @schedule_response.declined!

    if @schedule_response.valid_responder?(current_user) && @schedule_response.save
      redirect_to schedule_path(@schedule_response.responder), success: "Responded to #{@schedule_response.receiver.user.name}'s schedule"
    else
      redirect_to schedule_path(@schedule_response.responder), danger: "Unable to respond."
    end 
  end

  private

  def schedule_response_params
    params.require(:schedule_response).permit(:responder_id)
  end
end
