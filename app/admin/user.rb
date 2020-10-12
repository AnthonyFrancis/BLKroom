ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form do |f|
  f.inputs "Account Details" do
    f.input :id
    f.input :email
    f.input :username
    f.input :email
    f.input :password, :label => "Password (leave blank if you don't want to change it)"
    f.input :password_confirmation
  end
  f.actions
end


index do
    selectable_column
    column :id
    column :username
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column "Sign in", :sign_in_count
    column :created_at
    actions
  end

permit_params :name, :id, :email, :investor, :username, :password, :password_confirmation

controller do 

  def edit
  @user = User.find_by_username params[:id]
  end

  def update
  @user = User.find_by_username(permitted_params[:id])
  super
  end

  def show
  @user = User.find_by_username params[:id]
  end

  def destroy
  @user = User.find_by_username params[:id]
  super
  end

end

end