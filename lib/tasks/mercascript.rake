require 'scrapper'

namespace :mercascript do
  desc "refreshes results from all searches :D"
  task refresh_searches: :environment do
    Search.all.each do |search|
      merca = Mercadolibre.new
      scrap.fetch_results s search.name

      puts "hola #{search}"

    end
  end
end
