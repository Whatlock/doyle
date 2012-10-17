class AddLastGeneratedToStylesheet < ActiveRecord::Migration
  def change
    add_column :stylesheets, :last_generated, :datetime
  end
end
