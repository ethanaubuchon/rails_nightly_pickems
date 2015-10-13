class StandingsController < ApplicationController
  before_action :authenticate_user!

  def week
    now = DateTime.now.change(:offset => "-0400")

    @week = params["week"].to_i | 0
    time = (now - now.wday).end_of_day + @week.to_i.weeks

    @users = []

    games_this_week = Game.where(game_time: time..(time+1.week))
    winning_game_teams_this_week = GameTeam.where({
      id: Result.where(win: true).select(:game_team_id),
      game_id: games_this_week.select(:id)
    })
puts "#{params['week']}!!!!!!!!!!!!!!!!!!!!!!!!!!"
winning_game_teams_this_week.each{ |g| puts g.id }
    User.all.each do |user|
      u = {
        'displayname' => user.displayname,
      }
      wins = Pick.where(user_id: user.id, game_team_id: winning_game_teams_this_week).count
      losses = Pick.where(user_id: user.id).where.not(game_team_id: winning_game_teams_this_week).count
      u['wins'] = wins
      u['losses'] = losses
      u['nopicks'] = games_this_week.count - (wins + losses)
      @users.push(u)
    end
  end
end