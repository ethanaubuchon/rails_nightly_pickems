json.array!(@scores) do |score|
  json.extract! score, :id, :home, :away
  json.url score_url(score, format: :json)
end
