class ApplicationController < ActionController::Base
    include Pagy::Backend
    protect_from_forgery with: :exception
    before_action :authenticate_user!

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :address, :contatno, :email, :password, :role) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :address, :contatno, :email, :role, :password, :current_password) }
        end
end
