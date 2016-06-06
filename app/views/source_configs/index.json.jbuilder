json.array!(@source_configs) do |source_config|
  json.extract! source_config, :id, :datasource, :login, :password, :domain, :active, :data
  json.url source_config_url(source_config, format: :json)
end
