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

play_archive = "#{node[:play][:home]}.zip"
play_path = "#{node[:play][:install_prefix]}/#{node[:play][:home]}"
play_user = node[:play][:user]
play_group = node[:play][:group]


# Download Play Framework
remote_file "#{node[:play][:download_prefix]}/#{play_archive}" do
  source node[:play][:download_url]
  action :create_if_missing
end

# Unzip and Install
execute "install-play" do
  user "root"
  cwd node[:play][:download_prefix]
  command "unzip #{play_archive} -d #{node[:play][:install_prefix]}"
  not_if do
    File.exists?("#{play_path}")
  end
end

# Create Symbolic Link
execute "create-symlink-to-play-dir" do
  user "root"
  command "ln -sf #{play_path}/play /usr/bin/play"
end

# Initialize Play (and Get Scala/sbt)
execute "initialize-play" do
  user "root"
  command "play help"
end

# Set Permissions
execute "set-play-permissions" do
  user "root"
  command <<-EOF
    chmod 0755 #{play_path}/play
    chmod 0755 #{play_path}/framework/sbt/sbt-launch.jar
    chmod 0664 #{play_path}/framework/sbt/boot/sbt.boot.lock
    chmod 0664 #{play_path}/framework/sbt/boot/update.log
  EOF
end

# Cleanup
execute "delete-downloaded-play-zip" do
  user "root"
  command "rm #{node[:play][:download_prefix]}/#{play_archive}"
  only_if do
    File.exists?("#{node[:play][:download_prefix]}/#{play_archive}")
  end
end

execute "delete-play-samples" do
  user "root"
  command "rm -R #{play_path}/samples"
  only_if do
    File.exists?("#{play_path}/samples")
  end
end
