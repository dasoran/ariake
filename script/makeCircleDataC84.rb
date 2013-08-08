#!/usr/bin/env ruby1.9.1
# coding: utf-8
require 'nkf'

event_name = "C84"

event = Event.find_by_name(event_name)

f = open("data/%s/%sROM.TXT" % [event_name, event_name], "r:utf-16le")
f.each do |line|
  datas = line.split("\t")

  map_layout = MapLayout.joins(:comiket_block).where("map_layouts.space_number = %d and comiket_blocks.name = '%s'" % [datas[6].to_i, NKF::nkf("-WwZ1", datas[5])]).first
  if map_layout.nil?
    next
  end

  rom_data = CircleRomDatas.new
  rom_data.map_layout_id = map_layout.id
  rom_data.rom_id = datas[0]
  rom_data.page = datas[1]
  rom_data.cut_index = datas[2]
  rom_data.attend = datas[3]
  rom_data.genre_code = datas[7]
  rom_data.circle_name = datas[8]
  rom_data.circle_name_kana = datas[9]
  rom_data.author = datas[10]
  rom_data.book_name = datas[11]
  rom_data.url = datas[12]
  rom_data.mail = datas[13]
  rom_data.comment = datas[14]
  rom_data.appended_comment = datas[15]
  rom_data.circlems_url = datas[16]
  rom_data.rss_url = datas[17]
  rom_data.save
end
f.close


