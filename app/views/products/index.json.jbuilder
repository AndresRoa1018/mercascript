json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :url, :sold, :description_html, :type, :created_at, :updated_at, :source
  json.url product_url(product, format: :json)
end
