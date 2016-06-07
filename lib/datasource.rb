class Datasource
  
  def initialize(source_config)
    @source_config = source_config
  end

  def fetch_all
  
  end

  def self.list_sources
    Dir["#{Rails.root}/lib/datasources/*.rb"].map do |file|
      File.basename file, ".rb"
    end
  end
end