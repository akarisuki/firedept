module RoomHelper
    def opened_user(room)
        entry = room.entries.where.not(user_id: current_user)
        username = entry[0].user.username 
        tag.p "#{username}"
    end

    def most_new_message_preview(room)
        lastMessage = room.message.order(created_at: :desc).limit(1)
        @message = lastMessage[0]
        @message.present?
        tag.p "#{@message.message}", class: "empty"
      
    end

    def most_new_message_date(room)
        lastMessage = room.message.order(created_at: :desc).limit(1)
        @message = lastMessage[0]
        @message.present?
        tag.p "#{@message.updated_at.strftime("%Y-%m-%d %H:%M")}"
    end
end