class ComiketArea < ActiveRecord::Base
  attr_accessible :name, :map_e_w, :map_id
  has_one :comiket_area
end
