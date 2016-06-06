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
      result_page.search("#searchResults li").each do |result|
        rp = ResultProduct.new
        rp.name = result.at("h2 a").text
        rp.price = result.at(".price-info").text
        rp.url = result.at(".item-url").text
        rp.sold = result.at(".extra-info-sold").text
        rp.type = result.at(".extra-info-condition").text
        rp.created_at = result.Time.now
        rp.source = result.at(".item-url").text
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
