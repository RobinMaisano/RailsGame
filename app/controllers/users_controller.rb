class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    @tournaments_distinct = @user.tournaments.distinct(:id)

    sql = "SELECT DISTINCT game_id, name FROM PARTICIPATINGS INNER JOIN GAMES ON PARTICIPATINGS.game_id = GAMES.id WHERE user_id = #{@user.id}"
    @result = ActiveRecord::Base.connection.execute(sql)

    # @participatings_distinct = @user.participatings.dinstinct(:game_id)
    # puts "================================="
    # puts @participatings_distinct.inspect
    # puts "================================="
    # puts @user.participatings.distinct(:game_id).inspect
    # puts "================================="

  end
end