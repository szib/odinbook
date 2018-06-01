# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource({})
    resource.build_profile
    respond_with self.resource
  end

  # POST /resource
  def create
    super
    current_user.profile.avatar.attach(avatar_param) if avatar_param.present?
    UserMailer.with(user: current_user).welcome_mail.deliver_later
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    params = devise_parameter_sanitizer.sanitize(:account_update)

    @user = User.find(current_user.id)
    if need_password?
      successfully_updated = @user.update_with_password(params)
    else
      params.delete('current_password')
      params.delete('password')
      params.delete('password_confirmation')
      successfully_updated = @user.update_without_password(params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      bypass_sign_in @user
      redirect_to current_user
    else
      render 'edit'
    end

  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) { |u|
      u.permit(:email, :password, :password_confirmation,
               profile_attributes: [ :first_name, :last_name, :location, :avatar ] )
    }
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update) { |u|
      u.permit(:email, :password, :password_confirmation, :current_password,
        profile_attributes: [ :first_name, :last_name, :avatar, :location, :id ] )
      }
  end

  def avatar_param
    params.dig(:profile_attributes, :avatar)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def need_password?
    @user.email != params[:user][:email] || params[:user][:password].present?
  end
end
