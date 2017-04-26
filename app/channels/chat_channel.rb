class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_#{params[:match_id]}"
  end

  def receive(data)
    @message = Message.new(match_id: params[:match_id], user_id: data["sent_by"].to_i, content: data["content"])

    if @message.save
      ActionCable.server.broadcast("match_#{@message.match_id}", { sent_by: @message.user_id, content: @message.content })
    end
  end
end