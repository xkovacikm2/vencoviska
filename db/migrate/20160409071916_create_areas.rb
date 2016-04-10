class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.references :city

      t.timestamps null: false
    end
  end
end
