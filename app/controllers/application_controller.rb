class ApplicationController < ActionController::Base
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected
  def configure_devise_permitted_parameters
    # Add columns into the allowed parameter for sign up action
    devise_parameter_sanitizer.permit(:sign_up, keys:[{ role_names: [] }, :admin, :broker, :buyer, :status])
  end

  def after_sign_in_path_for(resource)
    static_pages_welcome_path
  end
end
