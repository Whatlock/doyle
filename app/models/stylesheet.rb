class Stylesheet < ActiveRecord::Base
  attr_accessible :author, :options, :primary_color

  before_save :add_version_number

  def stylesheet_url
    "#{root_url}/stylesheets/whatson/1FF0044-87e8e632e5bc6c8a0866dba19b383b0d.css"
  end

  private

  def add_version_number
    self.version = "1.0"
  end
end
