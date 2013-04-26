class Event < ActiveRecord::Base
  attr_accessible :name, :begin_at, :end_at
  has_many :orders
  has_many :entries
end