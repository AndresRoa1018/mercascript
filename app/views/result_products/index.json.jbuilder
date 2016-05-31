json.array!(@result_products) do |result_product|
  json.extract! result_product, :id, :name, :nick_seller, :price, :url, :sold, :description_html, :type
  json.url result_product_url(result_product, format: :json)
end
