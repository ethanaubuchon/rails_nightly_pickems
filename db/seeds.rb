p "Adding teams"
teams = JSON.parse(File.read('db/fixtures/teams.json'))
teams.each do |team|
  Team.create!(team)
end
p "Teams added"
p "Adding games"
game_data = JSON.parse(File.read('db/fixtures/games.json'))
count = 0
total = game_data.count
game_data.each do |data|
  p "#{count}/#{total} games added" if count % 10 == 0
  count += 1
  date = (data["date"]+" "+data["time"]).to_datetime.change(offset: "-0400")
  home_team = Team.find_by(short: data["home_team"])
  away_team = Team.find_by(short: data["away_team"])
  Game.create!(home_team_id: home_team.id, away_team_id: away_team.id, game_time: date)
end