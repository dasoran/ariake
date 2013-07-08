class Order < ActiveRecord::Base
  attr_accessible :user_id, :handout_id, :quantity
  belongs_to :user
  belongs_to :handout
  has_many :executors
end
