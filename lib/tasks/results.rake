namespace :results do
  task update: :environment do
    value = %x( node ../nhl_scraper/main scores)
    data = JSON.parse(value)

    data.each do |result|
      g = Game.where(id: GameTeam.where(team_id: Team.find_by(short: result["away_team"]).id).select(:game_id))
        .where(id: GameTeam.where(team_id: Team.find_by(short: result["home_team"]).id).select(:game_id))
        .where(game_time: DateTime.parse(result["date"] + " " + result["time"]).in_time_zone)


      diff = result["home_score"].to_i - result["away_score"].to_i

      if !Result.exists?(game_team_id: g.take.home_game_team.id)
        Result.create(
          game_team_id: g.take.home_game_team.id,
          win: (diff >= 0),
          differential: diff.abs
        )
      end

      if !Result.exists?(game_team_id: g.take.away_game_team.id)
        Result.create(
          game_team_id: g.take.away_game_team.id,
          win: (diff <= 0),
          differential: diff.abs
        )
      end
    end
  end

end
