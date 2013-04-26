class Handout < ActiveRecord::Base
  attr_accessible :entry_id, :goods_id
  belongs_to :entry
  belongs_to :goods
end
