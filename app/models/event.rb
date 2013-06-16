class Event < ActiveRecord::Base
  attr_accessible :name, :begin_at, :end_at
  has_many :entries
  has_many :map_layouts
  has_many :comiiket_blocks
end
