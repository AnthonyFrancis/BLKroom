class AddAdminRightsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin_rights, :boolean, default: false
  end
end
