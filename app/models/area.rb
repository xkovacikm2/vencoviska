class Area < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  belongs_to :area_color
  has_many :comments

  validates :name, presence: true, length: {maximum: 255}
  validates :geom, presence: true
  validates :user_id, presence: true
  validates :city_id, presence: true
end
