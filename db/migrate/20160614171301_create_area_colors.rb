class CreateAreaColors < ActiveRecord::Migration
  def change
    create_table :area_colors do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
