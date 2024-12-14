# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, if: :devise_controller? #デバイスコントローラーを使う場合、nameキーが使えるようにする

  # GET /resource/sign_in
   def new
     @user = User.new
     super
   end

   def after_sign_in_path_for(resource)
    my_page_path
   end

   def after_sign_out_path_for(resource)
    top_path
   end

   
   
   
  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.


   protected

   def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
   end
end
