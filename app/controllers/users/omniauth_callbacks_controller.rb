class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    # Attempt to find the User
    @user = User.find_for_facebook_oauth(
      request.env["omniauth.auth"]
    )

    if @user.persisted?
      flash[:notice] = "Has ingresado via Facebook"
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = "ERRRROooOOOoooooOoOOr!!!!!"
      redirect_to new_user_registration_url
    end
  end

end
