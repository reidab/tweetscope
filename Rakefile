# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rake'

namespace :site do

  desc "creates a new site"
  task :create, [:site_name] do |t, args|
    print "Site Name: "
    if site_name = args.site_name
      puts site_name
    else
      site_name = STDIN.readline.chomp
    end
    
    site_dir = "sites/#{site_name}"
    public_dir = "public/#{site_name}"
    
    raise "Site already exists" if File.exists?(site_dir)
    
    puts "Creating directories: #{site_dir}, #{public_dir}"
    FileUtils.mkdir_p([site_dir, public_dir])
    
    puts "Copying site files."
    File.open("#{site_dir}/config.yml",'w') {|f| f.write( open('lib/site_skel/config.yml').read.gsub("%%_SITENAME_%%",site_name) ) }
    
    File.open("#{site_dir}/index.haml",'w') {|f| f.write( open('lib/site_skel/index.haml').read.gsub("%%_SITENAME_%%",site_name) ) }
    
    puts "Copying public files."
    FileUtils.cp('lib/site_skel/public/style.css',public_dir)
  end

end