class User < ActiveRecord::Base
  attr_accessible :login_id, :pass_hash, :name
  has_many :orders

  class << self
    def authenticate(login_id, password)
      user = self.find_by_login_id(login_id)
      if user && user.pass_hash? &&
          BCrypt::Password.new(user.pass_hash) == password
        user
      else
        nil
      end
    end
  end
end
