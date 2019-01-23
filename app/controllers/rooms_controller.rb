class RoomsController < ApplicationController
  def show
    @messages = Message.all.limit(500)
  end
end
