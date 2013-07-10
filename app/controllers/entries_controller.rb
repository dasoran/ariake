# coding: utf-8
class EntriesController < ApplicationController
  before_filter :login_required

  def index
    @event = Event.find_by_name("C84") 

    @day = params[:day]
    @sort = params[:sort]
    @sort_vec = params[:vec]
    @page = params[:page].nil? ? 1 : params[:page]

    sortList = {
      "placeup" => "entries.attend_at, comiket_blocks.name, map_layouts.space_number, sub_place",
      "placedown" => "entries.attend_at desc, comiket_blocks.name desc, map_layouts.space_number desc, sub_place desc",
      "circlenameup" => "circles.name",
      "circlenamedown" => "circles.name desc",
      "updatedatup" => "entries.updated_at",
      "updatedatdown" => "entries.updated_at desc",
      }

    if @sort.nil?
      @entries = Entry.includes(:map_layout => :comiket_block).
        where("map_layouts.event_id = %d %s" % [@event.id, @day.nil? ? "" : "and attend_at = "+@day]).
        order("%s" % sortList["placeup"]).
        paginate(page: @page, per_page: 20)
    else
      @entries = Entry.includes(:map_layout => :comiket_block).includes(:circle).
        where("map_layouts.event_id = %d %s" % [@event.id, @day.nil? ? "" : "attend_at = "+@day]).
        order("%s" % sortList[@sort+@sort_vec]).
        paginate(page: @page, per_page: 20)
    end
  end 


  def search
    @event = Event.find_by_name("C84") 

    @day = params[:day]
    @sort = params[:sort]
    @sort_vec = params[:vec]

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
  end


  def show
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
    @circles = Circle.where("circles.name like '%%%s%%' or circles.author like '%%%s%%'" % [params[:search_text], params[:search_text]])
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
    map_layout = MapLayout.joins(:comiket_block).where("map_layouts.space_number = %d and comiket_blocks.name = '%s'" % [params[:space_number], params[:block_name]]).first

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
