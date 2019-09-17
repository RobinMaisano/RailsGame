class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]
  before_action :set_variables, only: [:add_participant, :destroy_participant]
  before_action :check_date, only:  [:add_participant, :destroy_participant]

  authorize_resource

  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.all.order(:id)
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
    authorize! :participate, Tournament
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(tournament_params)

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /tournaments/participate/1
  def add_participant

    # If max player is reached, break
    if @tournament.participatings.where(game_id: @game.id).size >= @tournament.max_players
      redirect_to tournament_path(@tournament), alert: 'Maximum number of player reached for this game'
      return
    end

    # # If date is reached, break
    # if DateTime.now.utc > @tournament.date
    #   redirect_to tournament_path(@tournament), alert: "It's too late to register for this tournament"
    #   return
    # end

    # Check if user's already a participant in this game-tournament
    exists = @tournament.participatings.where(user_id: current_user.id).where(game_id: @game.id)

    if exists.size > 0 # If he's, redirect and notice
      redirect_to tournament_path(@tournament), alert: "You'r already registered for this game"

    else # Make him a participant
      @tournament.participatings.new(user_id: current_user.id, game_id: @game.id)
      @tournament.save

      redirect_to tournament_path(@tournament), notice: "You've been successfully added to participant list."

    end

    # if @tournament.users.include?(current_user)
    #   redirect_to tournament_path(@tournament), notice: "You'r already a Participant of this tournament"
    #   return
    # end
    # if @tournament.max_players > @tournament.users.count
    #   @tournament.users.push(current_user)
    #   @tournament.save
    #   redirect_to tournament_path(@tournament), notice: 'You have been successfully added to participant list.'
    # else
    #   redirect_to @tournament, alert: 'There are no more places available in this tournament.'
    # end
  end

  # POST /tournaments/not_participate/1
  def destroy_participant
    exists = @tournament.participatings.where(user_id: current_user.id).where(game_id: @game.id)

    if exists.size > 0
      @tournament.participatings.delete(exists)
      @tournament.save

      redirect_to tournament_path(@tournament), notice: "You've been successfully removed from participant"
    else
      redirect_to tournament_path(@tournament)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    def set_variables
      @tournament = Tournament.find(params[:tournament_id])
      @game = Game.find(params[:game_id])
    end

  def check_date
    # If date is reached, break
    if DateTime.now.utc > @tournament.date
      redirect_to tournament_path(@tournament), alert: "It's too late to act on this tournament"
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:name, :description, :date, :max_players, game_ids: [])
    end
end
