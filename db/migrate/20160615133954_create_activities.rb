class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.text :link

      t.timestamps null: false
    end
  end
end
