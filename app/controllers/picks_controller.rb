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

  def index
    @day = params["day"].to_i
    if !@day || @day < 0
      @day = 0
    end

    @users = User.all
    @games = Game.where(
      'game_time BETWEEN ? AND ?',
      @day.day.ago.beginning_of_day,
      @day.day.ago.end_of_day
    ).all
    @data = Array.new
    @games.each do |game|
      g = Hash.new
      g["game"] = game.home_team.city + " " + game.home_team.name + " @ " + game.away_team.city + " " + game.away_team.name
      User.all.each do |user|
        pick = Pick.find_by(user_id: user.id, game_id: game.id)
        if pick
          pick_string = pick.team.city + " " + pick.team.name
        else
          pick_string = "N/A"
        end
        g[user.email] = pick_string
      end
      @data << g
    end
  end
end
