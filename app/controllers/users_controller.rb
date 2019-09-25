class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    @tournaments_distinct = @user.tournaments.distinct(:id)

    # @test_distinc = @user.participatings.distinct(:game_id)

    a_participatings = @user.participatings.to_a

    a_uniq_participatings = a_participatings.uniq {|s| s.game_id}

    uniq_participatings = @user.participatings.uniq {|s| s.game_id}

    # puts "================================="
    # puts uniq_participatings.inspect
    # puts "================================="
    # puts @distinc.inspect
    # puts "================================="

    # sql = "SELECT DISTINCT game_id, name FROM PARTICIPATINGS INNER JOIN GAMES ON PARTICIPATINGS.game_id = GAMES.id WHERE user_id = #{@user.id}"
    # @result = ActiveRecord::Base.connection.execute(sql)

    # @result = a_uniq_participatings
    #
    @result = uniq_participatings

  end
end