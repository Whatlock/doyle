class Stylesheet < ActiveRecord::Base
  attr_accessible :author, :options, :primary_color, :version

  before_save :set_version

  private

  def set_version
    self.version = "1.0"
  end
end
