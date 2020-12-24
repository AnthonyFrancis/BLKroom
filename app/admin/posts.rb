ActiveAdmin.register Post do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :body, :url, :post_image, :post_video, :user_id, :room_id, :slug
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :url, :post_image, :post_video, :user_id, :room_id, :slug]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

form do |f|
  f.inputs "Post Details", :multipart => true do
    f.input :id
    f.input :title
    f.input :post_image, :as => :file, :hint => f.object.post_image.present? \
      ? image_tag(f.object.post_image.url, width:100, height:100) 
      : content_tag(:span, "No photo yet")
      f.input :post_image_cache, :as => :hidden 
    f.input :post_video, :as => :file, :hint => f.object.post_video.present? \
      ? video_tag(f.object.post_video.url, width:100, height:100) 
      : content_tag(:span, "No video yet")
      f.input :post_video_cache, :as => :hidden 
    f.input :body
    f.input :url
    f.input :votes_count
    f.input :room_id
    f.input :created_at
  end
  f.actions
end


index do
    selectable_column
    column :id
    column "Image" do |f|
      f.post_image? ? image_tag(f.post_image.url, height: '100') : content_tag(:span, "No photo yet")
    end
    column "Video" do |f|
      f.post_video? ? video_tag(f.post_video.url, height: '100') : content_tag(:span, "No video yet")
    end
    column :title
    column :body
    column :url
    column :votes_count
    column :room_id
    column :created_at
    actions
  end

permit_params :title, :body, :url, :post_image, :post_video, :room_id, :created_at, :votes_count
  
end
