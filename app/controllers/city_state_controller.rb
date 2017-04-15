class CityStateController < ApplicationController
  skip_before_action :verify_authenticity_token

  include CityStateHelper

  def state
    respond_to do |format|
      format.json { render json: get_states(params[:country]) }
    end
  end

  # def city
  #   p params
  #   respond_to do |format|
  #     format.json { render json: CS.get(params[:country], params[:state]) }
  #   end
  # end
end
