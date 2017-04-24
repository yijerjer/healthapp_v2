class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_#{params[:match_id]}"
  end

  def receive(data)
    ActionCable.server.broadcast("match_#{params[:match_id]}", data)
  end
end