json.array!(@enemies) do |enemy|
  json.extract! enemy, :id, :name, :hero_id
  json.url enemy_url(enemy, format: :json)
end
