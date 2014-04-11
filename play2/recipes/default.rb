#
# Author:: Saad Ahmed (@saad3645)
# Cookbook Name:: play2
# Recipe:: default
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


include_recipe "java"

play_archive = "#{node[:play][:install_dir]}.zip"
play_path = "#{node[:play][:install_path]}/#{node[:play][:install_dir]}"
play_user = node[:play][:user]
play_group = node[:play][:group]


# Download Play Framework
remote_file "#{node[:play][:download_path]}/#{play_archive}" do
  source node[:play][:download_url]
  action :create_if_missing
end

# Unzip and Install
execute "install-play" do
  user "root"
  cwd node[:play][:download_path]
  command "unzip #{play_archive} -d #{node[:play][:install_path]}"
  not_if do
    File.exists?("#{play_path}")
  end
end

# Set Permissions
execute "set-play-permissions" do
  user "root"
  cwd node[:play][:install_path]
  command "chmod -R 0775 #{node[:play][:install_dir]}"
end

# Create Symbolic Link
execute "create-symlink-to-play-dir" do
  user "root"
  command "ln -sf #{play_path}/play /usr/bin/play"
end

# Initialize Play (and Get Scala if needed)
execute "initialize-play" do
  user "root"
  command "play help"
end

# Cleanup
execute "cleanup-play-setup" do
  user "root"
  cwd node[:play][:download_path]
  command "rm #{play_archive}"
  only_if do
    File.exists?("#{node[:play][:download_path]}/#{play_archive}")
  end
end
