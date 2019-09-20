class MatchesController < ApplicationController

  before_action :set_match, only: [ :edit, :update]


  def index
    @matches = Match.all.order(:id)
  end

  def edit
  end

  def update
    if @match.update(match_params)
      redirect_to matches_path, notice: "Winner updated"
    else
      render :edit
    end
  end

  def generate_winners

    matches_result_generate = Match.all.where(winner: nil)

    matches_result_generate.each do |match|

      random = rand(0..1)

      if random == 0
        match.winner = match.player1.name
      else
        match.winner = match.player2.name
      end
      match.save
    end

    redirect_to matches_path
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def match_params
    params.require(:match).permit(:winner)
  end

end