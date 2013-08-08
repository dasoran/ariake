# coding: utf-8
class User < ActiveRecord::Base
  attr_accessible :login_id, :name, :password
  attr_accessible :login_id, :name, :password, :administrator, :color, :is_pending, :permission,  as: :admin
  attr_accessor :password
  has_many :orders
  has_many :executors
  validates :login_id,
    format: {with: /\A[A-Za-z]\w*\z/, allow_blank: true},
    length: {minimum: 1, maximum: 30, allow_blank: true},
    uniqueness: {case_sensitive: false}
  validates :name,
    length: {minimum: 1, maximum: 30, allow_blank: true}
  validates :password,
    format: {with: /\A[A-Za-z]\w*\z/, allow_blank: true},
    length: {minimum: 1, maximum: 30, allow_blank: true}

  def password=(val)
    if val.present?
      self.pass_hash = BCrypt::Password.create(val)
    end
    @password = val
  end
  class << self
    def authenticate(login_id, password)
      user = self.find_by_login_id(login_id)
      if user && user.pass_hash? &&
          BCrypt::Password.new(user.pass_hash) == password
        
        unless user.permission == "stop"
          user
        else
          nil
        end
        
      else
        nil
      end
    end
  end
end
