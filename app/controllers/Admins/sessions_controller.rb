# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    # check_if_logged_in
    super
  end

  # POST /resource/sign_in
  def create
    # check_if_logged_in
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def after_sign_out_path_for(resource)
    :admins_root
  end

  def after_log_ing_path_for(resource)
    :admins_root
  end
end
