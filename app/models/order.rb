class Order < ActiveRecord::Base
  attr_accessible :event_id, :circle_id, :user_id, :handout_id
  belongs_to :event
  belongs_to :circle
  belongs_to :user
  belongs_to :handout
end
