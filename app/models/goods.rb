class Goods < ActiveRecord::Base
  attr_accessible :price, :is_generic, :name
  has_many :circle_goods_lists
end
