class CircleUrl < ActiveRecord::Base
  attr_accessible :circle_id, :page_url, :page_attr
  belongs_to :circle
end
