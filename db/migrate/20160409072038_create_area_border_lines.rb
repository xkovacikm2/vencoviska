class CreateAreaBorderLines < ActiveRecord::Migration
  def change
    create_table :area_border_lines do |t|
      t.float :x_from
      t.float :y_from
      t.float :x_to
      t.float :y_to
      t.references :area, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
