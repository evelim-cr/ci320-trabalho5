json.array!(@heros) do |hero|
  json.extract! hero, :id, :name, :skills, :city
  json.url hero_url(hero, format: :json)
end
