require 'scrapper'

namespace :mercascript do
  desc "refreshes results from all searches :D"
  task refresh_searches: :environment do
    Search.all.each do |search|
      puts "searching #{search.name}"
      SourceConfig.where(active: true).each do |sc|
        puts " .. #{sc.datasource}"
        sc.fetch_results search
      end
    end
  end
end
