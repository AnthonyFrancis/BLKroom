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
    f.input :title
    f.input :description
    f.input :sidebar
    f.input :created_at
  end
  f.actions
end


index do
    selectable_column
    column :name
    column :title
    column :description
    column :sidebar
    column :created_at
    actions
  end
  
end
