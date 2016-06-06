require 'rubygems'
require 'open-uri'
require 'mechanize'
require 'pry'

class Scrapper 


  def mechanizer(search)
      mecha = Mechanize.new
      url = "http://www.mercadolibre.com.pe/"
      page = mecha.get(url)
      #binding.pry
      page.form.field.value = search
      result_page = page.form.submit
      result_page.search("#searchResults > li").each do |result|
        #binding.pry
        source_id = result.attr(:id)

        puts " * parsing element"

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



  def scrapping(search)
    uri= 'http://listado.mercadolibre.com.co/#{search}#D[A:#{search}]'
    html = open(uri)
    
    doc = Nokogiri::HTML(html)
    

=begin
    doc.xpath(".list-view-item").each do |search|
      Search.create(:name => record.text)
    doc.xpath(".ch-price").each do |search|
      Search.create(:data => record.text)
=end

      doc.search(".ch-price").each do |price|
        puts price.inner_text
      
      end
  #end
   # end
    
  end
  
end
puts "type the article"
search = gets.chomp
scrap=Scrapper.new
scrap.mechanizer search

puts "hola #{search}"
