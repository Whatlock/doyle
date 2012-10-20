# encoding: utf-8

class StylesheetUploader < CarrierWave::Uploader::Base
  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  def store_dir
    if Rails.env.production?
      model.version
    else
      "stylesheets/#{model.version}"
    end
  end

  def cache_dir
    "#{Rails.root}/tmp/stylesheets"
  end
end
