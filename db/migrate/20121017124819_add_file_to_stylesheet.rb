class AddFileToStylesheet < ActiveRecord::Migration
  def change
    add_column :stylesheets, :file, :string
  end
end
