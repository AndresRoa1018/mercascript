class MercadoLibre < Datasource
  PAGES_TO_EXAMINE = 5

  def publish
  end

  def fetch_results(search)
      mecha = Mechanize.new
      url = "http://www.mercadolibre.com#{@source_config.domain}/"
      puts url
      page = mecha.get(url)
      page.form.field.value = search

      result_page = page.form.submit
      
      products = result_page.search("#searchResults > li").map{|p| p}

      (PAGES_TO_EXAMINE-1).times do
        products += mecha.click(result_page.at(".ch-pagination a.prefetch"))
                        .search("#searchResults > li").map{|p| p}
      end
      
      products.each do |result|
        product_page = mecha.click result.at("h2.list-view-item-title a")
        puts " *   #{search}  parsing element #{product_page.uri}"
        seller = product_page.links.map(&:href).select{|x| x && x.include?("perfil")}.first.split('/').last rescue nil

        source_id = result.attr(:id)

        
        if ResultProduct.exists?({source_id: source_id})
          puts "ya existe"
        else
          rp = ResultProduct.new
          
          begin
            metas = Hash[product_page.search('meta[itemprop]').map{|m| [m[:itemprop], m[:content]]}]

            rp.name = result.at("h2 a").text
            rp.price = metas["price"]
            rp.currency = metas["priceCurrency"]
            rp.url = result.at("h2 a").attr :href
            rp.sold = result.at(".extra-info-sold").try :text
            rp.is_new = result.at(".extra-info-condition").try(:text) == "Artículo nuevo"
            rp.source = "MercadoLibre"
            rp.source_id = source_id
            rp.nick_seller = seller
            rp.description_html = product_page.at("section.item-description, div.vip-description-container, #itemDescription").try :to_html 
          rescue NoMethodError => e
            binding.pry
            puts "NoMethodError: #{e.message}"
          rescue
            binding.pry
            puts "otro error: #{e.message}"
          ensure
            rp.save
          end  
          puts "EUREKAAAAAA!!! FUNCIONA"
        end
      end

  rescue Mechanize::ResponseCodeError => e
    puts e.message
  end
end



