json.array!(@photos) do |photo|
  json.extract! photo, :id, :order
  json.url photo_url(photo, format: :json)
end
