# coding: utf-8
# このコントローラはコミケ専用
# イベントごとにMAP用のコントローラを作る。
# 
# MAPの値固定の話は、画像から取得等を別途考える


class MapController < ApplicationController
  def index

    # mock data (あとでカタROM の情報に置き換える)
    comiket_area = [{"name" => "東123壁", "mapId" => "123"},
      {"name" => "東1", "mapId" => "123"}, 
      {"name" => "東2", "mapId" => "123"}, 
      {"name" => "東3", "mapId" => "123"},
      {"name" => "東456壁", "mapId" => "456"},
      {"name" => "東4", "mapId" => "456"},
      {"name" => "東5", "mapId" => "456"},
      {"name" => "東6", "mapId" => "456"},
      {"name" => "西2壁", "mapId" => "12"},
      {"name" => "西2", "mapId" => "12"},
      {"name" => "西1", "mapId" => "12"},
      {"name" => "西1壁", "mapId" => "12"}]
    comiket_block = {"A" => 0,
      "B" => 1,
      "C" => 1,
      "D" => 1,
      "E" => 1,
      "F" => 1,
      "G" => 1,
      "H" => 1,
      "I" => 1,
      "J" => 1,
      "K" => 1,
      "L" => 1}
    @comiket_layout = {"A" => [{"x" => "1240", "y" => "450", "layout" => "2"}, 
      {"x" => "1240", "y" => "440", "layout" => "2"}, 
      {"x" => "1240", "y" => "430", "layout" => "2"}, 
      {"x" => "1240", "y" => "400", "layout" => "2"}, 
      {"x" => "1240", "y" => "380", "layout" => "2"},
      {"x" => "1240", "y" => "360", "layout" => "2"},
      {"x" => "1240", "y" => "330", "layout" => "2"},
      {"x" => "1240", "y" => "320", "layout" => "2"},
      {"x" => "1240", "y" => "310", "layout" => "2"},
      {"x" => "1240", "y" => "300", "layout" => "2"},
      {"x" => "1240", "y" => "220", "layout" => "2"},
      {"x" => "1240", "y" => "210", "layout" => "2"},
      {"x" => "1240", "y" => "200", "layout" => "2"},
      {"x" => "1240", "y" => "190", "layout" => "2"},
      {"x" => "1240", "y" => "160", "layout" => "2"},
      {"x" => "1240", "y" => "140", "layout" => "2"},
      {"x" => "1240", "y" => "120", "layout" => "2"},
      {"x" => "1240", "y" => "90", "layout" => "2"},
      {"x" => "1240", "y" => "80", "layout" => "2"},
      {"x" => "1240", "y" => "70", "layout" => "2"},
      {"x" => "1220", "y" => "40", "layout" => "3"},
      {"x" => "1210", "y" => "40", "layout" => "3"},
      {"x" => "1190", "y" => "40", "layout" => "3"},
      {"x" => "1170", "y" => "40", "layout" => "3"},
      {"x" => "1160", "y" => "40", "layout" => "3"},
      {"x" => "1140", "y" => "40", "layout" => "3"},
      {"x" => "1130", "y" => "40", "layout" => "3"},
      {"x" => "1100", "y" => "30", "layout" => "3"},
      {"x" => "1070", "y" => "30", "layout" => "3"},
      {"x" => "950", "y" => "40", "layout" => "3"},
      {"x" => "940", "y" => "40", "layout" => "3"},
      {"x" => "920", "y" => "40", "layout" => "3"},
      {"x" => "910", "y" => "40", "layout" => "3"},
      {"x" => "900", "y" => "40", "layout" => "3"},
      {"x" => "880", "y" => "40", "layout" => "3"},
      {"x" => "870", "y" => "40", "layout" => "3"},
      {"x" => "800", "y" => "40", "layout" => "3"},
      {"x" => "790", "y" => "40", "layout" => "3"},
      {"x" => "770", "y" => "40", "layout" => "3"},
      {"x" => "760", "y" => "40", "layout" => "3"},
      {"x" => "750", "y" => "40", "layout" => "3"},
      {"x" => "730", "y" => "40", "layout" => "3"},
      {"x" => "720", "y" => "40", "layout" => "3"},
      {"x" => "690", "y" => "30", "layout" => "3"},
      {"x" => "660", "y" => "30", "layout" => "3"},
      {"x" => "540", "y" => "40", "layout" => "3"},
      {"x" => "530", "y" => "40", "layout" => "3"},
      {"x" => "510", "y" => "40", "layout" => "3"},
      {"x" => "500", "y" => "40", "layout" => "3"},
      {"x" => "490", "y" => "40", "layout" => "3"},
      {"x" => "470", "y" => "40", "layout" => "3"},
      {"x" => "460", "y" => "40", "layout" => "3"},
      {"x" => "390", "y" => "40", "layout" => "3"},
      {"x" => "380", "y" => "40", "layout" => "3"},
      {"x" => "360", "y" => "40", "layout" => "3"},
      {"x" => "350", "y" => "40", "layout" => "3"},
      {"x" => "340", "y" => "40", "layout" => "3"},
      {"x" => "320", "y" => "40", "layout" => "3"},
      {"x" => "310", "y" => "40", "layout" => "3"},
      {"x" => "280", "y" => "30", "layout" => "3"},
      {"x" => "250", "y" => "30", "layout" => "3"},
      {"x" => "130", "y" => "40", "layout" => "3"},
      {"x" => "120", "y" => "40", "layout" => "3"},
      {"x" => "100", "y" => "40", "layout" => "3"},
      {"x" => "90", "y" => "40", "layout" => "3"},
      {"x" => "70", "y" => "40", "layout" => "3"},
      {"x" => "50", "y" => "40", "layout" => "3"},
      {"x" => "40", "y" => "40", "layout" => "3"},
      {"x" => "20", "y" => "70", "layout" => "4"},
      {"x" => "20", "y" => "80", "layout" => "4"},
      {"x" => "20", "y" => "90", "layout" => "4"},
      {"x" => "20", "y" => "120", "layout" => "4"},
      {"x" => "20", "y" => "140", "layout" => "4"},
      {"x" => "20", "y" => "160", "layout" => "4"},
      {"x" => "20", "y" => "190", "layout" => "4"},
      {"x" => "20", "y" => "200", "layout" => "4"},
      {"x" => "20", "y" => "210", "layout" => "4"},
      {"x" => "20", "y" => "220", "layout" => "4"},
      {"x" => "20", "y" => "300", "layout" => "4"},
      {"x" => "20", "y" => "310", "layout" => "4"},
      {"x" => "20", "y" => "320", "layout" => "4"},
      {"x" => "20", "y" => "330", "layout" => "4"},
      {"x" => "20", "y" => "360", "layout" => "4"},
      {"x" => "20", "y" => "380", "layout" => "4"},
      {"x" => "20", "y" => "400", "layout" => "4"},
      {"x" => "20", "y" => "430", "layout" => "4"},
      {"x" => "20", "y" => "440", "layout" => "4"},
      {"x" => "20", "y" => "450", "layout" => "4"}]}
    # mock data
    area_to_str = { "e" => "東", "w" => "西" }

    day = params[:day] || "1"
    area = params[:area] || "e"
    subarea = params[:subarea] || "123"
    map_id = day + area + subarea
    @map_id = map_id.upcase

    event_name = params[:event] || "c84"
    event = Event.find_by_name event_name.upcase
    entries = event.entries
    @entries = []
    entries.each do |entry|
      entry.handouts.each do |handout|
        if handout.orders.count != 0 then
          next if entry.attend_at != day.to_i # 該当日に参加しているか
          next if area_to_str[area] != entry.place[0]
          area_id = comiket_block[entry.place[1]]
          next if subarea != comiket_area[area_id]["mapId"]
          
          @entries << entry
          break
        end
      end
    end

    render "index"
  end
end
