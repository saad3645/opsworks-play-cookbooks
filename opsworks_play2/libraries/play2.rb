#
# Author:: Saad Ahmed (@saad3645)
#
# Copyright 2013-2014, Saad Ahmed
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


def play_options(app_node)
  options = []

  if app_node[:play][:options][:http][:port]
    options << "-Dhttp.port=#{app_node[:play][:options][:http][:port]}"
  end

  if app_node[:play][:options][:https][:port]
    options << "-Dhttps.port=#{app_node[:play][:options][:https][:port]}"
  end

  if app_node[:play][:options][:config][:resource]
    options << "-Dconfig.resource=#{app_node[:play][:options][:config][:resource]}"
  elsif app_node[:play][:options][:config][:file]
    options << "-Dconfig.file=#{app_node[:play][:options][:config][:file]}"
  elsif app_node[:play][:options][:config][:url]
    options << "-Dconfig.url=#{app_node[:play][:options][:config][:url]}"
  end

  if app_node[:play][:options][:logger][:resource]
    options << "-Dlogger.resource=#{app_node[:play][:options][:logger][:resource]}"
  elsif app_node[:play][:options][:logger][:file]
    options << "-Dlogger.file=#{app_node[:play][:options][:logger][:file]}"
  elsif app_node[:play][:options][:logger][:url]
    options << "-Dlogger.url=#{app_node[:play][:options][:logger][:url]}"
  end

  return options.join(" ")
end


#def normalize_app_name(build_file_path, app_name)
#  File.open(build_file_path).readlines.each do |line|
#    if line.match('^name\\s*:=\\s*\"(([A-Za-z0-9_]+)(-[A-Za-z0-9_]+)*)+\"$')
#      line.sub('-', '_')
#	end
#  end	
#end
