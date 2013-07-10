class Entry < ActiveRecord::Base
  attr_accessible :circle_id, :attend_at, :map_layout_id, :sub_place, :goods_updated_at, :updated_at, :notice, :is_pending
  belongs_to :circle
  belongs_to :map_layout
  has_many :handouts
  before_create :set_goods_updated_at_to_now
  before_update :set_goods_updated_at_to_now
  def set_goods_updated_at_to_now
    self.goods_updated_at = Time.now
  end
end
