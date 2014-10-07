# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

teams = JSON.parse(File.read('db/fixtures/teams.json'))
teams.each do |team|
  Team.create!(team)
end

game_data = JSON.parse(File.read('db/fixtures/games.json'))
game_data.each do |data|
  date = Time.zone.parse(data["datetime"]).utc.in_time_zone('Eastern Time (US & Canada)')
  home_team = Team.where(short: data["home"]).first
  away_team = Team.where(short: data["away"]).first
  Game.create!(home_team: home_team, away_team: away_team, game_time: date)
end