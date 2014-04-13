include_attribute "deploy::deploy"

default[:play][:application][:options][:http][:port]       = "80"
default[:play][:application][:options][:https][:port]      = "443"
default[:play][:application][:options][:config][:resource] = nil
default[:play][:application][:options][:config][:file]     = nil
default[:play][:application][:options][:config][:url]      = nil
default[:play][:application][:options][:logger][:resource] = nil
default[:play][:application][:options][:logger][:file]     = nil
default[:play][:application][:options][:logger][:url]      = nil

default[:play][:deploy][:conf] = {}


node[:deploy].each do |application, deploy|
  default[:deploy][application][:play] = node[:play][:application]
end
