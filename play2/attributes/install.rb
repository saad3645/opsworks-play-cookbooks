default[:play][:version]       = "2.2.2"
default[:play][:base_url]      = "http://downloads.typesafe.com/play"
default[:play][:download_url]  = "#{node[:play][:base_url]}/#{node[:play][:version]}/play-#{node[:play][:version]}.zip"
default[:play][:download_path] = "/tmp"
default[:play][:install_path]  = "/opt"
default[:play][:install_dir]   = "play-#{node[:play][:version]}"

default[:play][:user]          = "root"
default[:play][:group]         = "root"
