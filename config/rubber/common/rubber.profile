<%
  @path = "/etc/profile.d/rubber.sh"
  current_path = "/mnt/#{rubber_env.app_name}-#{Rubber.env}/current" 
%>

# convenience to simply running rails console, etc with correct env
export RUBBER_ENV=<%= Rubber.env %>
export RAILS_ENV=<%= Rubber.env %>
export AWS_ACCESS_KEY_ID=<%= rubber_env.aws_access_key_id %>
export AWS_SECRET_ACCESS_KEY=<%= rubber_env.aws_secret_access_key %>
export AWS_S3_BUCKET=<%= rubber_env.aws_s3_bucket %>
alias current="cd <%= current_path %>"
alias release="cd <%= Rubber.root %>"

# Always use rubygems
export RUBYOPT="rubygems"
