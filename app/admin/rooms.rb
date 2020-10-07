ActiveAdmin.register Room, :as => 'Rooms Details' do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :title, :description, :sidebar, :user_id, :slug
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :title, :description, :sidebar, :user_id, :slug]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
permit_params :name, :title, :description, :sidebar, :user_id, :created_at


form do |f|
  f.inputs "Room Details", :multipart => true do
    f.input :name
    #f.input :post_image, :as => :file, :hint => image_tag(f.object.post_image.url,width:100,height:100)
    f.input :title
    f.input :description
    f.input :sidebar
    f.input :created_at
  end
  f.actions
end


index do
    selectable_column
    #column "photo" do |f|
      #image_tag(f.post_image.url,width:50,height:50)
    #end
    column :name
    column :title
    column :description
    column :sidebar
    column :created_at
    actions
  end
  
end
