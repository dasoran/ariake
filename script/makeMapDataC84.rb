#!/usr/bin/env ruby1.9.1
# coding: utf-8
require 'nkf'

event = Event.find_by_name("C84")

f = open("data/C84/C82DEF.TXT", "r:cp932")
def_texts = Hash::new

label = ""
f.each do |line|
  line = line[0...-2]
  next if line[0] == "#"
  next if line == ""

  if line[0] == "*"
    label = line.slice(1..-1)
    def_texts[label] = Array::new
    next
  end

  def_texts[label] << line

end
f.close

def_texts["ComiketArea"].each do |rawdata|
  rawdata = NKF::nkf("-WwZ1", rawdata)
  datas = rawdata.split("\t")

  area = ComiketArea.new
  area.name = datas[0]
  area.map_e_w = datas[0][0] == "東" ? "e" : "w"
  area.map_id = datas[1].slice(1..-1)
  area.save
  datas[2].split(//).each do |block_name|
    block = ComiketBlock.new
    block.name = block_name
    block.comiket_area_id = area.id
    block.save
  end
end


f = open("data/C84/C82MAP.TXT", "r:utf-16le")
f.each do |line|
  block_name, space_number, x, y, layout = line.split("\n")[0].split("\t")
  block = ComiketBlock.find_by_name(block_name)
  map_layout = MapLayout.where(event_id: event.id,
    comiket_block_id: block.id,
    space_number: space_number, 
    x: x, y: y, layout: layout).first
  
  map_layout = MapLayout.new if map_layout.nil?


  map_layout.event_id = event.id
  map_layout.comiket_block_id = block.id
  map_layout.space_number = space_number
  map_layout.x = x
  map_layout.y = y
  map_layout.layout = layout
  map_layout.save
end
f.close

