class MercadoLibre < Datasource
  
  def publish
  end

  def fetch_results(search)
      mecha = Mechanize.new
      url = "http://www.mercadolibre.com#{@source_config.domain}/"
      page = mecha.get(url)
      #binding.pry
      page.form.field.value = search
      result_page = page.form.submit
      result_page.search("#searchResults > li").each do |result|
        #binding.pry
        source_id = result.attr(:id)

        puts " *     parsing element"

        if ResultProduct.exists?({source_id: source_id})
          puts "ya existe"
        else
          rp = ResultProduct.new
          #binding.pry
          begin
            rp.name = result.at("h2 a").text
            rp.price = result.at(".price-info").text
            rp.url = result.at("h2 a").attr :href
            rp.sold = result.at(".extra-info-sold").try :text
            rp.is_new = result.at(".extra-info-condition").try(:text) == "Artículo nuevo"
            rp.source = "MercadoLibre"
            rp.source_id = source_id
            rp.save
          rescue NoMethodError => e
            binding.pry
            puts "something"
          end  
        end
        
      end
  end
end



