json.array!(@games) do |game|
  json.extract! game, :id, :game_time, :home_team_id, :away_team_id
  json.url game_url(game, format: :json)
end
