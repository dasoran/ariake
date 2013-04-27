class Order < ActiveRecord::Base
  attr_accessible :user_id, :handout_id
  belongs_to :user
  belongs_to :handout
  has_one :executor
end
