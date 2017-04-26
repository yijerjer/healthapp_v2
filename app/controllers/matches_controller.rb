class MatchesController < ApplicationController
  before_action :authenticate_user!, :check_user_attributes_exist

  def index
    @matches = Match.matches_of_user(current_user)
  end

  def show
    @match = Match.find_by_id(params[:id])
    unless @match.users.include?(current_user)
      redirect_to :back, danger: "Unauthouried action."
    end

    @messages = Message.includes(:user).where(match_id: params[:id]).order('created_at')
  end

end
