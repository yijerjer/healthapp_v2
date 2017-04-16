class MatchesController < ApplicationController
  def index
    @matches = Match.user_matches(current_user)
  end

  def show
    @match = Match.find_by_id(params[:id])
  end
end
