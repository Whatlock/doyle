# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

if Rails.env.production?
  delayed_job_config = YAML.load_file "#{Rails.root}/config/delayed_job.yml"
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == delayed_job_config['username'] && password == delayed_job_config['password']
  end
end

run WhatsonDoyle::Application
