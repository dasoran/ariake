class CircleUrl < ActiveRecord::Base
  attr_accessible :circle_id, :page_url, :page_attr, :is_master_url
  belongs_to :circle
end
