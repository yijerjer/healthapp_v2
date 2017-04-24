class MessagesController < ApplicationController
  def create
    @message = Message.create(match_id: params[:match_id], user_id: current_user, content: message_params[:content])

    if @message.save
      ActionCable.server.broadcast("match_#{@message.match_id}", { sent_by: @message.user_id, content: @message.content })
    else
      redirect_to match_path(@message.match), danger: "Unable to send message."
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
