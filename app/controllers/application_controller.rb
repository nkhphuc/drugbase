class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
 
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :store_user_location!, if: :storable_location?

    rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
            format.json { render nothing: true, status: :not_found }
            format.html { redirect_to root_path, alert: exception.message, status: :not_found }
        end
    end

    protected
    
    def configure_permitted_parameters
        added_attrs = [:username, :name, :email, :password, :password_confirmation, :remember_me]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    def after_sign_in_path_for(resource_or_scope)
        stored_location_for(resource_or_scope) || super
    end

    private

    def current_workplace
        @current_workplace ||= Workplace.find(current_user[:workplace_id]) if user_signed_in?
    end

    def current_workplace?(workplace)
        current_workplace == workplace
    end

    def storable_location?
        request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end
  
    def store_user_location!
        store_location_for(:user, request.fullpath)
    end

    helper_method :current_workplace
end
