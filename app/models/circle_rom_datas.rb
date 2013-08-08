class CircleRomDatas < ActiveRecord::Base
  attr_accessible :rom_id, :page, :cut_index, :attend, :map_layout_id, :circle_name, :circle_name_kana, :author, :book_name, :url, :mail, :comment, :appended_comment, :circlems_url, :rss_url
  belongs_to :map_layout
end
