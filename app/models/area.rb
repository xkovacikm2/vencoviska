class Area < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  belongs_to :area_color
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: {maximum: 255}
  validates :geom, presence: true, uniqueness: true
  validates :city_id, presence: true
end
