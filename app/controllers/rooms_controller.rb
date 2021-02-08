class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms.joins(:messages).includes(:messages).order("messages.created_at desc")
  end

  def create
    @room = Room.create
    @JoinCurrentUser = Entry.create(user_id: current_user.id, room_id: @room.id)
    @JoinUser = Entry.create(join_room_params)
    @first_message = @room.messages.create(user_id: current_user.id, message: "初めまして")
    redirect_to room_path(@room.id)
  end

  def show
  end
end
