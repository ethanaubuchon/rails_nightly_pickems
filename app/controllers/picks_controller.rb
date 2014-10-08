class PicksController < ApplicationController
  before_action :authenticate_user!
  # POST /scores
  # POST /scores.json
  def create
    game = Game.find(params["game_id"].to_i)
    if game
      if game.home_team.id == params["team_id"].to_i
        team = game.home_team
      elsif game.away_team.id == params["team_id"].to_i
        team = game.away_team
      else
        @message =  "Team not playing in this game!"
        @success = false
      end

      @pick = Pick.new()
      @pick.team = team
      @pick.game = game
      @pick.user = current_user

      if @pick.save
        @message =  "You picked the "+team.name+"!"
        @success = true
      else
        @message =  "Failed to save pick!"
        @success = false
      end
    else
      @message = "Did not find game!"
      @success = false
    end
    respond_to do |format|
      format.json {
        render :json => {
          message: @message,
          status: @success
        }
      }
    end
  end
end
