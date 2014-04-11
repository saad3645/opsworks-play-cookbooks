include_attribute "deploy::deploy"

default[:play][:deploy][:options][:http][:port]       = "80"
default[:play][:deploy][:options][:https][:port]      = "443"
default[:play][:deploy][:options][:config][:resource] = nil
default[:play][:deploy][:options][:config][:file]     = nil
default[:play][:deploy][:options][:config][:url]      = nil
default[:play][:deploy][:options][:logger][:resource] = nil
default[:play][:deploy][:options][:logger][:file]     = nil
default[:play][:deploy][:options][:logger][:url]      = nil

default[:play][:deploy][:conf] = {}


node[:deploy].each do |application, deploy|
  default[:deploy][application][:play] = node[:play][:deploy]
end
