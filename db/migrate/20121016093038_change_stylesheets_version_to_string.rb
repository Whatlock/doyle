class ChangeStylesheetsVersionToString < ActiveRecord::Migration
  def change
    change_column :stylesheets, :version, :string
  end
end
