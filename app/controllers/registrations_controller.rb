class RegistrationsController < Devise::RegistrationsController

def create
  super
end


def edit
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = flash[:notice].to_a.concat resource.errors.full_messages
      clean_up_passwords resource
      set_minimum_password_length
      redirect_back(fallback_location: root_path)
    end
end

  protected

  def after_sign_up_path_for(resource)
    root_path
  end

  def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super if params["password"]&.present?

    # Allows user to update registration information without password.
    resource.update_without_password(params.except("current_password"))
  end

  

end