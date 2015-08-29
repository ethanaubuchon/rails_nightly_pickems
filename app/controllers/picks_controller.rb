class PicksController < ApplicationController
  before_action :authenticate_user!
  # POST /scores
  # POST /scores.json
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

  def create
    begin
      @game_team = GameTeam.find(params["game_team_id"].to_i)

      @pick = Pick.where(game_team: Game.find(@game_team.game.id).game_teams, user: current_user).first_or_create
      @pick.game_team = @game_team
      @pick.save!

      respond_to do |format|
        format.json {
          render :json => {message: "You picked " + @game_team.team.fullname.titleize}
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
end
