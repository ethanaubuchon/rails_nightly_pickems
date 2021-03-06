class StandingsController < ApplicationController
  before_action :authenticate_user!

  def week
    now = DateTime.now.in_time_zone

    @week = params["week"].to_i | 0
    time = (now - ((now.wday > 0) ? now.wday : 7).days).end_of_day + @week.to_i.weeks

    @users = []

    games_this_week = Game.where(game_time: time..(time+1.week).end_of_day)
    winning_game_teams_this_week = GameTeam.where({
      id: Result.where(win: true).select(:game_team_id),
      game_id: games_this_week.select(:id)
    })
    losing_game_teams_this_week = GameTeam.where({
      id: Result.where(win: false).select(:game_team_id),
      game_id: games_this_week.select(:id)
    })
    User.all.each do |user|
      u = {
        'displayname' => user.displayname,
      }
      wins = Pick.where(user_id: user.id, game_team_id: winning_game_teams_this_week).count
      losses = Pick.where(user_id: user.id, game_team_id: losing_game_teams_this_week).count
      u['wins'] = wins
      u['losses'] = losses
      u['nopicks'] = winning_game_teams_this_week.count - (wins + losses)
      @users.push(u)
    end
  end
end
