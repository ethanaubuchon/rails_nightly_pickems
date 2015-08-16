class PicksController < ApplicationController
  before_action :authenticate_user!
  # POST /scores
  # POST /scores.json
  def create
    begin
      @game = Game.find(params["game_id"].to_i)
      raise "Team not found" if !@game.has_team?(params["team_id"].to_i)
      @team = Team.find(params["team_id"].to_i)

      @pick = Pick.where(game: @game, user: current_user).first_or_create
      @pick.team = @team
      @pick.save!

      respond_to do |format|
        format.json {
          render :json => {message: "You picked " + @team.fullname.titleize}
        }
      end
    rescue => e
      p e
      respond_to do |format|
        format.json {
          render status: 400, :json => e
        }
      end
    end
  end

  def index
    @day = params["day"].to_i
    if !@day || @day < 1
      @day = 1
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
      g["game"] = game.home_team.city + " " + game.home_team.name +
                  " @ " + game.away_team.city + " " + game.away_team.name
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
