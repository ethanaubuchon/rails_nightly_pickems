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
    @path = "/picks"
    @users = User.all
    if (params["date"])
      @date = Date.parse(params["date"])
    else
      @date = Date.today
    end

    @games = Game.includes(:picks => :team).where(
      game_time: (@date)..(@date+1)
    ).order("game_time ASC")
  end
end
