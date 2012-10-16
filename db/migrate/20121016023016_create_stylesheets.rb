class CreateStylesheets < ActiveRecord::Migration
  def change
    create_table :stylesheets do |t|
      t.string :primary_color
      t.string :author
      t.text :options
      t.integer :version
      t.integer :views

      t.timestamps
    end
  end
end
