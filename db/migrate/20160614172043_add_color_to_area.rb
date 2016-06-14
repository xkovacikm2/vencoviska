class AddColorToArea < ActiveRecord::Migration
  def change
    add_reference :areas, :area_color, foreign_key: true, index: true
  end
end
