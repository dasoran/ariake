# coding: utf-8
class EntriesController < ApplicationController
  before_filter :login_required


  def difflist
    @event = Event.find_by_name("C84") 

    @days = ((@event.end_at - @event.begin_at + 1)/60/60/24)
    @day = params[:day]

    @entries = Entry.includes(:map_layout => :comiket_block).
      where("map_layouts.event_id = %d %s" % [@event.id, @day.nil? ? "" : "and attend_at = "+@day]).
      order("entries.attend_at, comiket_blocks.comiket_area_id, comiket_blocks.name, map_layouts.space_number, sub_place")
 
    require "csv"
    require "kconv"

    data = CSV.generate("",{:encoding => "sjis", :row_sep => "\r\n"}) do |csv|
      @entries.each do |e|
        attend = ['土', '日', '月'][e.attend_at - 1]
        rom_data = CircleRomDatas.joins(:map_layout => :comiket_block).
          where("map_layouts.space_number = %d and comiket_blocks.name = '%s' and attend = '%s'" % [e.map_layout.space_number, e.map_layout.comiket_block.name, attend])
        rom_data = e.sub_place == "a" ? rom_data[0] : rom_data[1]
        unless rom_data.circle_name == e.circle.name
          list_data = []
          list_data << rom_data.attend
          list_data << rom_data.map_layout.comiket_block.comiket_area.name[0]
          list_data << NKF::nkf("-WwXm0", rom_data.map_layout.comiket_block.name)
          list_data << rom_data.map_layout.space_number
          list_data << e.sub_place
          list_data << rom_data.circle_name
          list_data << rom_data.author
          csv << list_data
          list_data = []
          list_data << ""
          list_data << ""
          list_data << ""
          list_data << ""
          list_data << ""
          list_data << e.circle.name
          list_data << e.circle.author
          csv << list_data
        end
      end
    end
    send_data(data.tosjis, type: "text/csv", filename: "difflists_#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}.csv")
  end




  def downloadlist
    @event = Event.find_by_name("C84") 

    @days = ((@event.end_at - @event.begin_at + 1)/60/60/24)
    @day = params[:day]

    @entries = Entry.includes(:map_layout => :comiket_block).
      where("map_layouts.event_id = %d %s" % [@event.id, @day.nil? ? "" : "and attend_at = "+@day]).
      order("entries.attend_at, comiket_blocks.comiket_area_id, comiket_blocks.name, map_layouts.space_number, sub_place")
 
    require "csv"
    require "kconv"

    data = CSV.generate("",{:encoding => "sjis", :row_sep => "\r\n"}) do |csv|
      csv << ["Header", "ComicMarketCD-ROMCatalog","ComicMarket84","Shift_JIS","Windows 1.82.1"]
      csv << ["Color","1","4a94ff","4a94ff"]
      csv << ["Color","2","ff00ff","ff00ff"]
      @entries.each do |e|
        attend = ['土', '日', '月'][e.attend_at - 1]
        rom_data = CircleRomDatas.joins(:map_layout => :comiket_block).
          where("map_layouts.space_number = %d and comiket_blocks.name = '%s' and attend = '%s'" % [e.map_layout.space_number, e.map_layout.comiket_block.name, attend])
        rom_data = e.sub_place == "a" ? rom_data[0] : rom_data[1]
        list_data = ["Circle"]
        list_data << rom_data.rom_id
        list_data << 1
        list_data << rom_data.page
        list_data << rom_data.cut_index
        list_data << rom_data.attend
        list_data << rom_data.map_layout.comiket_block.comiket_area.name[0]
        list_data << NKF::nkf("-WwXm0", rom_data.map_layout.comiket_block.name)
        list_data << rom_data.map_layout.space_number
        list_data << rom_data.genre_code
        list_data << rom_data.circle_name
        list_data << rom_data.circle_name_kana
        list_data << rom_data.author
        list_data << rom_data.book_name
        list_data << rom_data.url
        list_data << rom_data.mail
        list_data << rom_data.comment
        list_data << ""
        list_data << rom_data.map_layout.x
        list_data << rom_data.map_layout.y
        list_data << rom_data.map_layout.layout
        list_data << e.sub_place == "a" ? 0 : 1
        list_data << rom_data.appended_comment
        list_data << rom_data.circlems_url.chomp
        list_data << rom_data.rss_url
        list_data << ""
        csv << list_data
      end
    end
    send_data(data.tosjis, type: "text/csv", filename: "checklists_#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}.csv")
  end




  def printlayout
    @event = Event.find_by_name("C84") 

    @days = ((@event.end_at - @event.begin_at + 1)/60/60/24)
    @day = params[:day]
    @sort = params[:sort]
    @sort_vec = params[:vec]

    sortList = {
      "placeup" => "entries.attend_at, comiket_blocks.comiket_area_id, comiket_blocks.name, map_layouts.space_number, sub_place",
      "placedown" => "entries.attend_at desc, comiket_blocks.comiket_area_id desc, comiket_blocks.name desc, map_layouts.space_number desc, sub_place desc",
      "circlenameup" => "circles.name",
      "circlenamedown" => "circles.name desc",
      "updatedatup" => "entries.updated_at",
      "updatedatdown" => "entries.updated_at desc",
      }

    if @sort.nil?
      @entries = Entry.includes(:map_layout => :comiket_block).
        where("map_layouts.event_id = %d %s" % [@event.id, @day.nil? ? "" : "and attend_at = "+@day]).
        order("%s" % sortList["placeup"])
    else
      @entries = Entry.includes(:map_layout => :comiket_block).includes(:circle).
        where("map_layouts.event_id = %d %s" % [@event.id, @day.nil? ? "" : "and attend_at = "+@day]).
        order("%s" % sortList[@sort+@sort_vec])
    end
    @all_count = @entries.count


    render layout: "printlayout"
  end

  def index
    @event = Event.find_by_name("C84") 

    @day = params[:day]
    @sort = params[:sort]
    @sort_vec = params[:vec]
    @page = params[:page].nil? ? "1" : params[:page]

    sortList = {
      "placeup" => "entries.attend_at, comiket_blocks.comiket_area_id, comiket_blocks.name, map_layouts.space_number, sub_place",
      "placedown" => "entries.attend_at desc, comiket_blocks.comiket_area_id desc, comiket_blocks.name desc, map_layouts.space_number desc, sub_place desc",
      "circlenameup" => "circles.name",
      "circlenamedown" => "circles.name desc",
      "updatedatup" => "entries.updated_at",
      "updatedatdown" => "entries.updated_at desc",
      }

    if @sort.nil?
      @entries = Entry.includes(:map_layout => :comiket_block).
        where("map_layouts.event_id = %d %s" % [@event.id, @day.nil? ? "" : "and attend_at = "+@day]).
        order("%s" % sortList["placeup"])
    else
      @entries = Entry.includes(:map_layout => :comiket_block).includes(:circle).
        where("map_layouts.event_id = %d %s" % [@event.id, @day.nil? ? "" : "and attend_at = "+@day]).
        order("%s" % sortList[@sort+@sort_vec])
    end


    @all_count = @entries.count
    @entries = @entries.
      paginate(page: @page, per_page: Ariake::Application.config.per_page)
  end 


  def search
    @event = Event.find_by_name("C84") 

    @day = params[:day]
    @sort = params[:sort]
    @sort_vec = params[:vec]

    @page = params[:page].nil? ? "1" : params[:page]

    sortList = {
      "placeup" => "comiket_blocks.name, map_layouts.space_number, sub_place",
      "placedown" => "comiket_blocks.name desc, map_layouts.space_number desc, sub_place desc",
      "circlenameup" => "circles.name",
      "circlenamedown" => "circles.name desc",
      "updatedatup" => "entries.updated_at",
      "updatedatdown" => "entries.updated_at desc",
      }

    @search_text = params[:search_text]
    search_words = params[:search_text].split(" ")
    @search_sql = []
    search_words.each do |word|
      @search_sql << "(circles.name like \"%%%s%%\" or circles.author like \"%%%s%%\")" % [word, word]
    end


    if @sort.nil?
      @entries = Entry.includes(:map_layout => :comiket_block).
        where("map_layouts.event_id = %d %s" % [@event.id, @day.nil? ? "" : "and attend_at = "+@day]).
        includes(:circle).where(@search_sql.join(" and ")).
        order("%s" % sortList["placeup"])
    else
      @entries = Entry.includes(:map_layout => :comiket_block).includes(:circle).
        where("map_layouts.event_id = %d %s" % [@event.id, @day.nil? ? "" : "attend_at = "+@day]).
        includes(:circle).where(@search_sql.join(" and ")).
        order("%s" % sortList[@sort+@sort_vec])
    end


    @all_count = @entries.count
    @entries = @entries.
      paginate(page: @page, per_page: Ariake::Application.config.per_page)

  end


  def show
    @event = Event.find_by_name("C84") 
    @day = params[:day]
    @page = params[:page].nil? ? "1" : params[:page]

    @entry = Entry.find_by_id(params[:id])
    @map_layout = @entry.map_layout
    @event = @map_layout.event
    @block = @map_layout.comiket_block
    @map_e_w_j = @block.comiket_area.name[0]
  end

  def new
    @event = Event.find_by_id(params[:event_id])
  end

  def new_searched
    @event = Event.find_by_id(params[:event_id])
    @circles = Circle.where("circles.name like \"%%%s%%\" or circles.author like \"%%%s%%\"" % [params[:search_text], params[:search_text]]).
    order("circles.id desc")
  end

  def new_detail
    @event = Event.find_by_id(params[:event_id])
    @events = Event.all
    @days = (@event.end_at - @event.begin_at + 1)/60/60/24
    @all_blocks = {"east" => Array::new, "west" => Array::new}
    ComiketBlock.all.each do |block|
      if block.comiket_area.name[0] == "東"
        @all_blocks["east"] << block
      else
        @all_blocks["west"] << block
      end
    end

    @circle = Circle.find_by_id(params[:circle_id])
  end

  def create
    # map_layout,comiket-block,comiket-area check
    if params[:space_number] == ""
      flash[:info] = "位置が空欄です。"
      return  redirect_to new_detail_entries_path(:circle_id => params[:circle], :event_id => params[:event])
    end
    map_layout = MapLayout.joins(:comiket_block).where("map_layouts.space_number = %d and comiket_blocks.name = '%s' and map_layouts.event_id = '%d'" % [params[:space_number], params[:block_name], params[:event]]).first

    if map_layout.nil?
      flash[:info] = "参加位置が間違えています。"
      return redirect_to new_detail_entries_path(:circle_id => params[:circle], :event_id => params[:event])
    end
    # map_layout,comiket-block,comiket-area check

    entry = Entry.new
    entry.circle_id = params[:circle].to_i
    entry.attend_at = params[:day].to_i
    entry.map_layout_id = map_layout.id
    entry.sub_place = params[:sub_place]
    entry.is_pending = false;
    entry.save

    flash[:success] = "%s を %s に追加しました。" % [entry.circle.name, Event.find_by_id(params[:event]).name]

    if params[:send_button] == "create"
      redirect_to entries_path
    else
      redirect_to edit_entry_path(entry.id)
    end
  end

  def edit
    @entry = Entry.find_by_id(params[:id])
    @events = Event.all
    @event = @entry.map_layout.event
    @days = (@event.end_at - @event.begin_at + 1)/60/60/24

    @map_layout = @entry.map_layout
    @block = @map_layout.comiket_block
    @map_e_w_j = @block.comiket_area.name[0]


    @all_blocks = {"east" => Array::new, "west" => Array::new}
    ComiketBlock.all.each do |block|
      if block.comiket_area.name[0] == "東"
        @all_blocks["east"] << block
      else
        @all_blocks["west"] << block
      end
    end

  end


  def update
  end

  def destroy
    entry = Entry.find_by_id(params[:id])
    entry.destroy
    redirect_to entries_path, success: "削除しました。"
  end

  def update_all
    if params[:space_number] == ""
      flash[:info] = "位置が空欄です。"
      return  redirect_to new_detail_entries_path
    end

    entry = Entry.find_by_id(params[:id])
    is_change = false

    # map_layout,comiket-block,comiket-area check
    map_layout = MapLayout.includes(:comiket_block).
      where("space_number = %d and comiket_blocks.name = '%s' and event_id = %d" % [params[:space_number], params[:block_name], params[:event]]).first

    if map_layout.nil?
      flash[:info] = "参加位置が間違えています。"
      return redirect_to edit_entry_path(params[:id])
    end
    # map_layout,comiket-block,comiket-area check

    unless params[:day].to_i == entry.attend_at
      entry.attend_at = params[:day].to_i
      is_change = true
      entry.save
    end

    unless map_layout == entry.map_layout
      entry.map_layout_id = map_layout.id
      is_change = true
      entry.save
    end

    unless params[:sub_place] == entry.sub_place
      entry.sub_place = params[:sub_place]
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

    unless entry.circle.circle_urls.count == 0 then
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

    params.each do |key, value|
      next unless key.split("-")[0] == "handout"
      handout_id = key.split("-")[1].to_i
      price = params["handoutprice-%d" % [handout_id]]
      handout = Handout.find_by_id(handout_id)
      goods = handout.goods

      next if goods.name == value && goods.price == price
      if goods.is_generic then
        handout.goods = Goods.new()
        handout.goods.is_generic = false
      end
      handout.goods.name = value
      handout.goods.price = price
      handout.goods.save
      handout.save
      is_change = true
    end
 



    if is_change then
      flash[:success] = "サークルのイベント登録情報を変更しました。"
    else 
      flash[:info] = "変更がありません。"
    end
    redirect_to entry_path(params[:id])
  end
end
