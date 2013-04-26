class Entry < ActiveRecord::Base
  attr_accessible :event_id, :circle_id, :attend_at, :goods_updated_at
  belongs_to :event
  belongs_to :circle
  has_many :circle_goods_lists
  before_create :set_goods_updated_at_to_now
  def set_goods_updated_at_to_now
    self.goods_updated_at = Time.now
  end
end
