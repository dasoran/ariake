# coding: utf-8
class UsersController < ApplicationController
  def new
    @user = User.new()
  end
  def create
    @user = User.new(params[:user])
    @user.administrator = false
    @user.color = "#000000"
    @user.is_pending = true
    if @user.save
      flash[:success] = "登録が完了しました。"
      redirect_to :root
    else
      flash[:error] = "エラー：フォームの入力事項を確認してください。"
      render "new"
    end
  end
  def login
    if @current_user
      redirect_to :root
    end
  end
  def entries
    @event = Event.find_by_name("C84") 
    @user = User.find_by_login_id(params[:id])

    @day = params[:day]
    @sort = params[:sort]
    @sort_vec = params[:vec]
    @page = params[:page].nil? ? 1 : params[:page]


    sortList = {
      "placeup" => "entries.attend_at, comiket_blocks.comiket_area_id, comiket_blocks.name, map_layouts.space_number, sub_place",
      "placedown" => "entries.attend_at desc, comiket_blocks.comiket_area_id desc, comiket_blocks.name desc, map_layouts.space_number desc, sub_place desc",
      "circlenameup" => "circles.name",
      "circlenamedown" => "circles.name desc",
      "updatedatup" => "entries.updated_at",
      "updatedatdown" => "entries.updated_at desc",
      }

    if @sort.nil?
      @entries = Entry.includes(:handouts => :orders).
        includes(:map_layout => :comiket_block).
        where("map_layouts.event_id = %d %s and orders.user_id = '%s'" %
          [@event.id, @day.nil? ? "" : "and attend_at = "+@day, @user.id]).
        order("%s" % sortList["placeup"])
    else
      @entries = Entry.includes(:handouts => :orders).
        includes(:map_layout => :comiket_block).includes(:circle).
        where("map_layouts.event_id = %d %s and orders.user_id = '%s'" %
          [@event.id, @day.nil? ? "" : "and attend_at = "+@day, @user.id]).
        order("%s" % sortList[@sort+@sort_vec])
    end

    @all_count = @entries.count
    @entries = @entries.
      paginate(page: @page, per_page: Ariake::Application.config.per_page)
  end
end
