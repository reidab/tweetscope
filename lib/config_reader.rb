class ConfigReader
  def self.read
    config = Hash.new
    config['_global'] = read_config_file('global_config.yml')
    Dir.foreach('sites') do |site|
      next if site == '.' || site == '..' || !File.directory?("sites/#{site}")
      config[site] = read_config_file("sites/#{site}/config.yml")
    end
    
    config['_domains'] = build_domain_map(config)
    
    config
  end
  
  private
  
  def self.read_config_file(file)
    (File.exists?(file) && YAML::load_file(file)) || {}
  end
  
  def self.build_domain_map(config)
    domain_map = {}
    config.reject{|k,v| !v.has_key?('domain') && !v.has_key?('domains')}.each do |k,v|
      [v['domain'],v['domains']].flatten.compact.each do |domain|
        domain_map[domain] = k
      end
    end
    domain_map
  end
end