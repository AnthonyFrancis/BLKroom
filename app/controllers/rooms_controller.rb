class RoomsController < ApplicationController
  #before_action :authenticate_user!, expect: [:index, :show]
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :admins_rights, only: [:new]
  
  respond_to :js, :html, :json

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @rooms = Room.all
    @room_posts = @room.posts.paginate(page: params[:page], per_page: 10).order("created_at desc")


    @grouped_posts = @room_posts.group_by { |t| t.created_at.to_date }

        if @grouped_posts[false].present?
          #Create day wise groups of posts      
          @post_wise_sorted_alerts = @grouped_posts[false].group_by { |t| t.created_at.wday}
        end
  end

  # GET /rooms/new
  def new
    @room = current_user.rooms.build
    @room.user_id = current_user.id
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = current_user.rooms.build(room_params)
    @room.user_id = current_user.id

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :title, :description, :sidebar, :user_id)
    end

    def correct_user
      unless @room.user_id == current_user.id
        redirect_to rooms_path, notice: "Not authorized to edit this room"

        #you must return false to halt
        false
      end
    end

    def admins_rights
      unless current_user.admin_rights == true
        redirect_to rooms_path, notice: "Not authorized to create a room"

        #you must return false to halt
        false
      end
    end
end