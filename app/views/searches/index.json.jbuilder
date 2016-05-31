json.array!(@searches) do |search|
  json.extract! search, :id, :name, :data
  json.url search_url(search, format: :json)
end
