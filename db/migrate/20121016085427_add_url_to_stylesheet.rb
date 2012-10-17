class AddUrlToStylesheet < ActiveRecord::Migration
  def change
    add_column :stylesheets, :url, :string
  end
end
