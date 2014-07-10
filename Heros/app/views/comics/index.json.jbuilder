json.array!(@comics) do |comic|
  json.extract! comic, :id, :name, :publishing, :date
  json.url comic_url(comic, format: :json)
end
