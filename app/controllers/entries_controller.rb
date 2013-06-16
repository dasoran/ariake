# coding: utf-8
class EntriesController < ApplicationController
  def index
    @event = Event.find_by_name("C84") 
    @entries = Entry.find_all_by_event_id(@event.id)
    #def search
    #  event = Event.find_by_name("C84")
    #  @entries = Entry.find_all_by_event_id(event.id)
    #  @entries = Entry.includes(:circle).where('circles.name LIKE ? OR circles.author LIKE ? OR entries.place LIKE ?','%'+params[:search_form]+'%','%'+params[:search_form]+'%','%'+params[:search_form]+'%')
    #  render "index"
    #end
  end 
  
  def show
    @entry = Entry.find_by_id(params[:id])
    @map_layout = @entry.map_layout
    @block = @map_layout.comiket_block
    @map_e_w_j = @block.comiket_area.name[0]
  end

  def new
    @event = Event.find_by_id(params[:event_id])
  end

  def edit
    @entry = Entry.find_by_id(params[:id])
    @events = Event.all
    @days = (@entry.event.end_at - @entry.event.begin_at + 1)/60/60/24

    @map_layout = @entry.map_layout
    @block = @map_layout.comiket_block
    @map_e_w_j = @block.comiket_area.name[0]
  end

  def create
  end

  def update
  end

  def destroy
    entry = Entry.find_by_id(params[:id])
    entry.destroy
    redirect_to entries_path, success: "削除しました。"
  end

  def update_all
    entry = Entry.find_by_id(params[:id])
    is_change = false

    unless params[:event].to_i == entry.event_id
      entry.event_id = params[:event].to_i
      is_change = true
      entry.save
    end

    unless params[:day].to_i == entry.attend_at
      entry.attend_at = params[:day].to_i
      is_change = true
      entry.save
    end

    # circle
    unless params[:circlename] == entry.circle.name
      entry.circle.name = params[:circlename]
      is_change = true
      entry.circle.save
    end

    unless params[:author] == entry.circle.author
      entry.circle.author = params[:author]
      is_change = true
      entry.circle.save
    end

    master_url_id = params[:masterRadios].to_i
    master_url = CircleUrl.find_by_id(master_url_id)
    present_master_url = CircleUrl.where(circle_id: entry.circle.id, is_master_url: true).first
    if present_master_url.nil?
      master_url.is_master_url = true
      is_change = true
      master_url.save
    else
      unless master_url_id == present_master_url.id
        present_master_url.is_master_url = false
        master_url.is_master_url = true
        is_change = true
        present_master_url.save
        master_url.save
      end
    end

    params.each do |key, value|
      next unless key.split("-")[0] == "url"
      url_id = key.split("-")[1].to_i
      url = CircleUrl.find_by_id(url_id)
      next if url.page_url == value

      url.page_url = value
      is_change = true
      url.save
    end

    #circle

    #params.each do |key, param|
    #  is_change = true
    #end
    if is_change then
      flash[:success] = "サークルのイベント登録情報を変更しました。"
    else 
      flash[:info] = "変更がありません。"
    end
    redirect_to entry_path(params[:id])
  end
end
