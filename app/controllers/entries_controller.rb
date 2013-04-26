# coding: utf-8
class EntriesController < ApplicationController
  def index
    event = Event.find_by_name("C84") 
    @entries = Entry.find_all_by_event_id(event.id)
   end 
end
