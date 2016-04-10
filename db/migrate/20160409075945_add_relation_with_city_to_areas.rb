class AddRelationWithCityToAreas < ActiveRecord::Migration
  def change
    remove_column :areas, :city_id
    add_reference :areas, :city, index: true, foreign_key: true
  end
end
