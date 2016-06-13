class AddPolygonToArea < ActiveRecord::Migration
  def change
    add_column :areas, :geom, :text
  end
end
