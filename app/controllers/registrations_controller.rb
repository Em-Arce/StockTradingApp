class RegistrationsController < Devise::RegistrationsController
  protected
  def after_sign_up_path_for(resource)
    static_pages_welcome_path
  end
end
