class StylesheetsController < ApplicationController
  before_filter :get_stylesheet, only: [:edit,:update,:destroy]

  def index
    @stylesheets = Stylesheet.all
  end

  def show
    @primary_color = params[:primary_color] || 'FFFFFF'

    raw = render_to_string template: 'stylesheets/template/1.0/whatlock.css.sass.erb', layout: nil
    erb = ERB.new(raw).result(binding)
    opts = Compass.configuration.to_sass_engine_options.merge syntax: :sass, style: :compressed
    opts[:load_paths] << Rails.root.join('app/views/stylesheets/template/1.0/').to_s
    sass = Sass::Engine.new(erb, opts).render

    render text: sass
  end

  def new
    @stylesheet = Stylesheet.new
    respond_with @stylesheet
  end

  def create
    @stylesheet = Stylesheet.create params[:stylesheet]
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

end
