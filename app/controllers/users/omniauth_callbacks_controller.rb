# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

    def facebook
    @user = User.from_facebook(request.env['omniauth.auth'])

    if @user.persisted?
      unless @user.facebook_id? # First connection w/ facebook, update profile to add Facebook_uid
        @user.facebook_id = request.env['omniauth.auth'].uid
        @user.save
      end
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.facebook'] = request.env['omniauth.auth'] # If registration fails, saves results in env var in order to fill the form
      redirect_to new_user_registration_url
    end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
