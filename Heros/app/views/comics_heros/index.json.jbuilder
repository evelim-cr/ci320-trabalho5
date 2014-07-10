json.array!(@comics_heros) do |comics_hero|
  json.extract! comics_hero, :id, :hero_id, :comic_id
  json.url comics_hero_url(comics_hero, format: :json)
end
