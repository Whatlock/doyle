class StylesheetGenerator
  def template_sass_file_for_version(version)
    Rails.root.join 'app', 'assets', 'stylesheets', 'template', version, 'whatlock.sass'
  end

  def compile(primary_color,options, version)

  end
end
