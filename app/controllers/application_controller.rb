# frozen_string_literal: true

#pass extra parameter in devise
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters    
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :number, :gender, :role, category_ids: []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :number, :gender, :role, category_ids: []])
  end
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = 'You are not authorized to perform this action!'
    redirect_to articles_path
    end
end
