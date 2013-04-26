class User < ActiveRecord::Base
  attr_accessible :login_id, :pass_hash, :name
  has_many :orders
end
