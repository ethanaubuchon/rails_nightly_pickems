class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  # GET /scores
  # GET /scores.json
  def index
    @day = params["day"].to_i
    if !@day
      @day = 0
    end

    @games = Game.where(
      'game_time BETWEEN ? AND ?',
      @day.day.ago.beginning_of_day.in_time_zone('Eastern Time (US & Canada)'),
      @day.day.ago.end_of_day.in_time_zone('Eastern Time (US & Canada)')
    ).all
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
  end

  # GET /scores/new
  def new
    @score = Score.new
  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores
  # POST /scores.json
  def create
    game_id = params[:game_id]
    home = params[:home].to_i
    away = params[:away].to_i
    respond_to do |format|
      format.json {
        if !current_user.admin? && !current_user.god?
          render :json => {
            message: "You don't have the permissions BITCH!",
            status: false
          }
        elsif !game_id || !home || !away
          render :json => {
            message: "Missing a parameter.  Please try again.",
            status: false
          }
        else
          @score = Score.where(game_id: game_id).first_or_create
          @score.home = home
          @score.away = away
          if @score.save
            render :json => {
              message: "Score saved",
              status: true
            }
          else
            render :json => {
              message: "Failed to save",
              status: false
            }
          end
        end
      }
    end
  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to @score, notice: 'Score was successfully updated.' }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url, notice: 'Score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end
end
