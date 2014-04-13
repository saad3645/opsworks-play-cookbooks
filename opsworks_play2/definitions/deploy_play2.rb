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


define :deploy_play2 do
  application = params[:app]
  deploy      = params[:deploy_data]
  app_dir     = node[:deploy][application][:current_path]
  stage_dir   = "target/universal/stage"
  stage_path  = "#{app_dir}/#{stage_dir}"
  play_start  = "#{stage_path}/bin/#{application}"
  options     = play_options(node[:deploy][application])

  # Deploy
  opsworks_deploy do
    app application
    deploy_data deploy
  end

  # Setup Logging
  directory "#{app_dir}/logs" do
    owner "deploy"
    group "apache"
    mode 0766
    action :create
  end

  # Stage App
  execute "stage-play-app #{application}" do
    cwd app_dir
    command "play clean stage &> #{app_dir}/logs/build.log"
  end

  # Create the service for the application
  template "/etc/init.d/#{application}" do
    source "init.d.play2_app.erb"
    owner "deploy"
    group "root"
    mode  "0755"
    backup false
    variables({
	  :app_name => application,
	  :app_path => app_dir,
	  :stage_path => stage_path,
	  :options => options,
	  #:env_vars => env_vars()
    })
  end

  # Start Play App as service
  service application do
    supports :start => true, :stop => true, :restart => true, :status => true 
    action [ :enable, :start ]
  end
end
