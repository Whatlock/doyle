class Stylesheet < ActiveRecord::Base

  LATEST_TEMPLATE_VERSION = '1.0'

  TEMPLATE_PATH_ROOT = Rails.root.join 'app', 'assets', 'whatlock'
  TEMPLATE_BASE_FILENAME = 'whatlock.css.sass.erb'
  EXPORT_PATH_ROOT = Rails.root.join 'public', 'stylesheets'

  attr_accessible :author, :options, :primary_color, :version

  validates_presence_of :primary_color

  before_save :validate_primary_color

  mount_uploader :file, StylesheetUploader

  def generate
    erb = ERB.new(template_file).result(binding)
    opts = Compass.configuration.to_sass_engine_options.merge syntax: :sass, style: :compressed
    opts[:load_paths] << Rails.root.join(template_path)
    Sass::Engine.new(erb, opts).render
  end

  def generate!
    FileUtils.mkdir_p export_path
    File.open(export_target, 'w') { |f| f.write generate }
    self.last_generated = DateTime.now
    self.file = File.open(export_target)
    save!
  end

  private

  def validate_primary_color
    self.primary_color = "##{self.primary_color}" if self.primary_color[0] != '#'
  end

  def template_path
    "#{TEMPLATE_PATH_ROOT}/#{version}/"
  end


  def template_file
    File.read(template_path + TEMPLATE_BASE_FILENAME)
  end

  def export_path
    "#{EXPORT_PATH_ROOT}/#{version}/"
  end

  def export_filename
    filename = Digest::MD5.hexdigest(self.primary_color + options.to_s)
    "doyle#{filename}.css"
  end

  def export_target
    export_path + export_filename
  end

end
