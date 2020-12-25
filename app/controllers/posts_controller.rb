class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :newest]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  respond_to :js, :html, :json

  # GET /posts
  # GET /posts.json
  def index
    @user = User.all
    @latest = User.where.not(username: [nil, ""])
    
    if user_signed_in?
        @posts = current_user.subscribed_posts.paginate(page: params[:page], per_page: 10).order("created_at desc")
        @random = Post.order("RANDOM()")

        #Retrives all post and divides into two groups todays messages and other messages
        @grouped_posts = @posts.group_by { |t| t.created_at.to_date }

        if @grouped_posts[false].present?
          #Create day wise groups of posts      
          @post_wise_sorted_alerts = @grouped_posts[false].group_by { |t| t.created_at.wday}
        end
    else
        @posts = Post.paginate(page: params[:page], per_page: 10).order("created_at desc")

        #Retrives all post and divides into two groups todays messages and other messages
        @grouped_posts = @posts.group_by { |t| t.created_at.to_date }

        if @grouped_posts[false].present?
          #Create day wise groups of posts      
          @post_wise_sorted_alerts = @grouped_posts[false].group_by { |t| t.created_at.wday}
        end  
    end

    @grouped_posts.each do |day, posts|
      @grouped_posts[day] = posts.sort {|a, b| b.votes_count <=> a.votes_count }
    end

    #my_temp_data  = @grouped_posts
    #@grouped_posts.each do |day, posts|
    #  if day == Date.today
    #    delete my_temp_data[day]
    #    my_temp_data["Today"] = posts
    #  end
    #end
    #@grouped_posts = my_temp_data

    today = Date.today # Today's date
    @days_from_this_week = (today.at_beginning_of_week..today.at_end_of_week).map
  end

  def newest
    @user = User.all
    @latest = User.where.not(username: [nil, ""])
    if user_signed_in?
        @posts = current_user.subscribed_posts.paginate(page: params[:page], per_page: 10).order("created_at desc")
        @popular = current_user.subscribed_posts.order(votes_count: :desc)
        @random = Post.order("RANDOM()")

        #Retrives all post and divides into two groups todays messages and other messages
        @grouped_posts = @posts.group_by { |t| t.created_at.to_date }

        if @grouped_posts[false].present?
          #Create day wise groups of posts      
          @post_wise_sorted_alerts = @grouped_posts[false].group_by { |t| t.created_at.wday}
        end
    else
        @posts = Post.paginate(page: params[:page], per_page: 10).order("created_at desc")

        #Retrives all post and divides into two groups todays messages and other messages
        @grouped_posts = @posts.group_by { |t| t.created_at.to_date }

        if @grouped_posts[false].present?
          #Create day wise groups of posts      
          @post_wise_sorted_alerts = @grouped_posts[false].group_by { |t| t.created_at.wday}
        end  
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
        if params[:came_from] == "post"
          format.html { redirect_to :root, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        end
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

  def unsubscribe
    user = User.find_by_unsubscribe_hash(params[:unsubscribe_hash])
    user.update_attribute(:comment_subscription, false)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :url, :post_image, :post_video, :room_id, :votes_count)
    end

    def correct_user
      unless @post.user_id == current_user.id
        redirect_to posts_path, notice: "Not authorized to edit this post"

        #you must return false to halt
        false
      end
    end
end