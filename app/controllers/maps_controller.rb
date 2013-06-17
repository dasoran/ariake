# coding: utf-8
# このコントローラはコミケ専用
# イベントごとにMAP用のコントローラを作る。
# 
# MAPの値固定の話は、画像から取得等を別途考える


class MapsController < ApplicationController
  # mock data (あとでカタROM の情報に置き換える)
  @@user_color = {"sora_sakaki" => "#55f",
    "xxyuiyaxx" => "#f55"}

  # mock data

  def index
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
          block = entry.map_layout.comiket_block
          carea = block.comiket_area
          next if entry.attend_at != day.to_i # 該当日に参加しているか
          next if area_to_str[area] != carea.name[0] 
          next if subarea.to_i != carea.map_id

          exe_users = []
          handout.orders.each do |order|
            unless order.executor.nil?
              exe_users << User.find_by_id(order.executor.user_id)
            end
          end
          @entries << {"entry" => entry, "exe_users" => exe_users}
          break
        end
      end
    end
    @user_color = @@user_color

    render "index"
  end
  def show
    area_to_str = { "e" => "東", "w" => "西" }

    executor = User.find_by_login_id params[:id]

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
      catch(:exit) {
        entry.handouts.each do |handout|
          if handout.orders.count != 0 then
            next if entry.attend_at != day.to_i # 該当日に参加しているか
            next if area_to_str[area] != entry.place[0]
            area_id = @@comiket_block[entry.place[1]]
            next if subarea != @@comiket_area[area_id]["mapId"]
            
            exe_users = []
            # 購入してくる人で絞り込み
            handout.orders.each do |order|
              next if order.executor.user_id != executor.id.to_i
              exe_users << User.find_by_id(order.executor.user_id)
              @entries << {"entry" => entry, "exe_users" => exe_users}
              throw :exit
            end
          end
        end
      }
    end
 


    @comiket_layout = @@comiket_layout
    @user_color = @@user_color
    render "index"
  end
end
