class RoomsController < ApplicationController
  def show
    @messages = Message.all.limit(20).order("created_at DESC")
  end
end
