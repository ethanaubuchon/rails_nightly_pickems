class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @path = "/games"
    if (params["date"])
      @datetime = DateTime.parse(params["date"]).end_of_day.in_time_zone.beginning_of_day
    else
      @datetime = DateTime.now.in_time_zone.beginning_of_day
    end

    @games = Game.includes(:game_teams => :team).where(
      game_time: (@datetime)..(@datetime.end_of_day)
    ).order("game_time ASC")
  end

  def search
    puts params
    @games = Game.includes(:game_teams => :team).all
    if (params["date"] && params["time"])
      date = (params["date"] + " " + params["time"]).in_time_zone
      @games = @games.where(game_time: date)
    elsif (params["date"])
      date = DateTime.parse(params["date"]).end_of_day.in_time_zone.beginning_of_day
      @games = @games.where(game_time: date..date.end_of_day)
    end

    if (params["home_team_id"])
      @games = @games.where(id: GameTeam.where(team_id: params["home_team_id"].to_i, home_team: true).select(:game_id))
    end

    if (params["away_team_id"])
      @games = @games.where(id: GameTeam.where(team_id: params["away_team_id"].to_i, home_team: false).select(:game_id))
    end

    respond_to do |format|
      format.json {
        render json: {
          data: @games.as_json(include: {
            game_teams: {
              include: :team
            }
          })
        }
      }
    end
  end

  def admin
    redirect_to root_path if current_user.role != "admin" && current_user.role != "god"
    @teams = Team.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    if current_user.role == "admin" || current_user.role == "god"
      @game = Game.new(game_time: params["date"] + " " + params["time"])

      @game.game_teams.build(team_id: params["home_team_id"], home_team: true)
      @game.game_teams.build(team_id: params["away_team_id"], home_team: false)
    end

    respond_to do |format|
      if current_user.role == :admin || current_user.role == :god || @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: { message: "Created Game" } }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  # def switch_teams
  #   Game.all.each do |game|
  #     temp = game.home_team
  #     game.home_team = game.away_team
  #     game.away_team = temp
  #     game.save
  #   end
  #   redirect_to root_path
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:game_time, :home_team_id, :away_team_id)
    end
end
