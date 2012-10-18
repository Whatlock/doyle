class StylesheetsController < ApplicationController

  before_filter :get_stylesheet, only: [:edit,:update,:destroy,:generate]

  respond_to :html

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
    #@stylesheet.delay.generate!
    @stylesheet.generate!
    respond_with @stylesheet, location: stylesheets_path
  end

  def generate
    #@stylesheet.delay.generate!
    @stylesheet.generate!
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
