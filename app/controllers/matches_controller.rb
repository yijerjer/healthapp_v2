class MatchesController < ApplicationController
  before_action :authenticate_user!, :check_user_attributes_exist

  def index
    @matches = Match.user_matches(current_user)
  end

  def show
    @match = Match.find_by_id(params[:id])

    unless @match.users.include?(current_user)
      redirect_to :back, danger: "Unauthouried action."
    end

  end

end
