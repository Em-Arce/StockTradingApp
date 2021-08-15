class ApplicationController < ActionController::Base
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    # Add columns into the allowed parameter for sign up action
    devise_parameter_sanitizer.permit(:sign_up, keys:[:admin, :broker, :buyer])
  end
end
