class MapLayout < ActiveRecord::Base
  attr_accessible :event_id, :comiket_block_id, :space_number, :x, :y, :layout
  belongs_to :event
  belongs_to :comiket_block
  has_one :entry
end
