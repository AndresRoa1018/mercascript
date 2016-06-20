require 'scrapper'

namespace :mercascript do
  desc "refreshes results from all searches :D"
  task refresh_searches: :environment do
    puts "no searches found" if Search.all.count == 0 
      
    Search.all.each do |search|
      puts "searching #{search.name}"
      SourceConfig.where(active: true).each do |sc|
        puts " .. #{sc.datasource}"
        sc.fetch_results search

      end
    end
  end

  desc "test"
  task test: :environment do
    source_config = SourceConfig.find 15
    result_product = ResultProduct.find 1
    m = Olx.new(source_config)
    m.publish result_product
  end
end
