class Circle < ActiveRecord::Base
  attr_accessible :name, :author
  has_many :orders
  has_many :entries
  has_many :circle_urls
end
