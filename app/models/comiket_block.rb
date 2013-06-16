  class ComiketBlock < ActiveRecord::Base
  attr_accessible :name, :comiket_area_id
  belongs_to :comiket_area
  has_many :map_layout
end
