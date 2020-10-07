class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  respond_to :js, :html, :json

  # GET /posts
  # GET /posts.json
  def index
    if user_signed_in?
        @pagy, @posts = pagy(current_user.subscribed_posts.order("created_at desc"), items: 8)
        @popular = Post.order(cached_votes_total: :desc)
        @random = Post.order("RANDOM()")

    else
        @pagy, @posts = pagy(Post.all, items: 8)
        @random = Post.order("RANDOM()")
    end

    today = Date.today # Today's date
    @days_from_this_week = (today.at_beginning_of_week..today.at_end_of_week).map
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @room = @post.room
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    @post = Post.find(params[:id])

    respond_to do |format|
      if params[:format] == "vote"
        @post.liked_by current_user
      elsif params[:format] == "unvote"
        @post.unliked_by current_user
        format.html {redirect_to @post}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :url, :post_image, :post_video, :room_id)
    end

    def correct_user
      unless @post.user_id == current_user.id
        redirect_to posts_path, notice: "Not authorized to edit this room"

        #you must return false to halt
        false
      end
    end
end