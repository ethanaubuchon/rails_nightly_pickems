class PicksController < ApplicationController
  before_action :authenticate_user!
  # POST /scores
  # POST /scores.json
  def index
    @path = "/picks"
    @users = User.all
    if (params["date"])
      @date = Date.parse(params["date"])
      date_for_range = DateTime.parse(params["date"]).change(:offset => "-0400")
    else
      @date = Date.today
      date_for_range = DateTime.now.change(:offset => "-0400")
    end

    @games = Game.includes(:game_teams => [:team, :picks]).where(
      game_time: (date_for_range.beginning_of_day)..(date_for_range.end_of_day)
    ).order("game_time ASC")
  end

  def create
    begin
      @game_team = GameTeam.find(params["game_team_id"].to_i)

      raise "Game time passed already... cheater!" if @game_team.game.game_time.to_i < DateTime.now.change(:offset => "-0400").to_i

      @pick = Pick.where(game_team: Game.find(@game_team.game.id).game_teams, user: current_user).first_or_create
      @pick.game_team = @game_team
      @pick.save!

      respond_to do |format|
        format.json {
          render :json => {message: "You picked #{@game_team.team.fullname.titleize}"}
        }
      end
    rescue => e
      p e
      respond_to do |format|
        format.json {
          render status: 400, :json => {message: e.to_s}
        }
      end
    end
  end
end
