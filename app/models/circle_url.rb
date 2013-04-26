class CircleUrl < ActiveRecord::Base
  attr_accessible :circle_id, :url, :attribute
  belongs_to :circle
end
