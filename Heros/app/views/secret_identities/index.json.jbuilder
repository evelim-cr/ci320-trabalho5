json.array!(@secret_identities) do |secret_identity|
  json.extract! secret_identity, :id, :name, :address, :ocupation, :hero_id
  json.url secret_identity_url(secret_identity, format: :json)
end
