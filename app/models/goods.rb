class Goods < ActiveRecord::Base
  attr_accessible :price, :name
  has_many :circle_goods_lists
end
