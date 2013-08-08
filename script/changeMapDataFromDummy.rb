
event = Event.find_by_name("C84")

Entry.all.each do |e|
  num = e.map_layout.space_number
  block = e.map_layout.comiket_block.name
  map = MapLayout.joins(:comiket_block).where("map_layouts.space_number = %d and comiket_blocks.name = '%s' and event_id = %d" % [num, block, event.id]).first
  e.map_layout_id = map.id
  e.save
end

