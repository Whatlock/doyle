class StylesheetsController < ApplicationController

  LATEST_TEMPLATE_VERSION = '1.0'

  TEMPLATE_PATH = 'app/assets/whatlock'
  TEMPLATE_FILENAME = 'whatlock.css.sass.erb'
  EXPORT_PATH = Rails.root.join 'public', 'stylesheets'

  before_filter :get_stylesheet, only: [:edit,:update,:destroy,:compile]
  before_filter :template_view_path

  respond_to :html

  def compile
    @primary_color = @stylesheet.primary_color
    @options = @stylesheet.options

    FileUtils.mkdir_p exports_directory
    File.open(target_stylesheet, 'w') {|f| f.write compiled }

    @stylesheet.last_generated = DateTime.now
    @stylesheet.url = target_stylesheet
    @stylesheet.save

    redirect_to stylesheets_path
  end

  def index
    @stylesheets = Stylesheet.all
  end

  def show
  end

  def new
    @stylesheet = Stylesheet.new
    respond_with @stylesheet
  end

  def create
    @stylesheet = Stylesheet.create params[:stylesheet]
    StylesheetGenerator.new(@stylesheet).delay.compile!
    flash[:notice] = "Stylesheet will be generated soon..."
    respond_with @stylesheet, location: stylesheets_path
  end

  def edit
    respond_with @stylesheet
  end

  def update
    @stylesheet.update_attributes params[:stylesheet]
    respond_with @stylesheet, location: stylesheets_path
  end

  def destroy
    @stylesheet.destroy
    respond_with @stylesheet
  end

  private

  def get_stylesheet
    @stylesheet = Stylesheet.find params[:id]
  end

  def template_view_path
    prepend_view_path TEMPLATE_PATH
  end

  def template_file
    "#{@stylesheet.version}/#{TEMPLATE_FILENAME}"
  end

  def compiled
    raw = render_to_string template: template_file, layout: nil
    erb = ERB.new(raw).result(binding)
    opts = Compass.configuration.to_sass_engine_options.merge syntax: :sass, style: :compressed
    opts[:load_paths] << "#{Rails.root}/#{TEMPLATE_PATH}/#{@stylesheet.version}"
    Sass::Engine.new(erb, opts).render
  end

  def exports_directory
    EXPORT_PATH.join @stylesheet.version
  end

  def target_stylesheet
    options = Digest::MD5.hexdigest(options.to_s)
    filename = "doyle-#{@stylesheet.primary_color}-#{options}.css"
    exports_directory.join filename
  end

end
