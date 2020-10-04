class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:create, :destroy]

  def create
    @subscription = @room.subscriptions.where(user_id: current_user.id).first_or_create

    respond_to do |format|
      format.html { redirect_to @room, notice: "You successfully subscribed to #{@room.name}"}
      format.js # create.js.erb
    end
  end

  def destroy
    @subscription = @room.subscriptions.where(user_id: current_user.id).first_or_create
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to @room, notice: "You successfully unsubscribed to #{@room.name}"}
      format.js # destroy.js.erb
    end

  end

  private

    def set_room
      @room = Room.find(params[:room_id])
    end
end