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

  def admin
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
    @game = Game.new game_time: params["date"] + " " + params["time"]

    @game.game_teams.build(team_id: params["home_team_id"], home_team: true)
    @game.game_teams.build(team_id: params["away_team_id"], home_team: false)

    respond_to do |format|
      if @game.save
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
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
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
