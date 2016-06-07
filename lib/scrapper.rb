require 'rubygems'
require 'open-uri'
require 'mechanize'
require 'pry'

class Scrapper 


 



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
