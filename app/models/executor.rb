class Executor < ActiveRecord::Base
  attr_accessible :user_id, :order_id
  belongs_to :order
end
