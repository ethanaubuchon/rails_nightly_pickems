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
  p "#{count} - #{data["date"]+" "+data["time"]}" if count > 930 && count < 940
  count += 1
  date = (data["date"]+" "+data["time"]).to_datetime.change(offset: "-0400")
  home_team = Team.where(short: data["home"]).first
  away_team = Team.where(short: data["away"]).first
  Game.create!(home_team: home_team, away_team: away_team, game_time: date)
end