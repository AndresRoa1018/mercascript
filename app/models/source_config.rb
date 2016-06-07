class SourceConfig < ActiveRecord::Base
  def get_datasource
    datasource.classify.constantize.new(self)
  end

  def fetch_results(search)
    get_datasource.fetch_results(search)
  end


end
