class Web::PasswordsController < Web::ApplicationController
  include ResetPasswordHelper

  def new
    @password = PasswordForm.new
  end

  def create
    @password = PasswordForm.new(password_params)    

    if User.exists?(email: password_params[:email])
      user = User.find_by(email: password_params[:email])
      generate_password_token!(user)
      UserMailer.with(user_id: user.id, url: root_url).reset_password.deliver_now
      redirect_to(:new_session)
    else
      flash[:error] = "Email not found. Please try again."
      render(:new)
    end
  end

  def edit
    @password = PasswordForm.new
  end

  def update
    user = User.find_by(reset_password_token: params[:id])
    @password = PasswordForm.new(password_params)
    @password.email = user.email
    if user.present? && password_token_valid?(user) && @password.valid?
      if reset_password!(user, password_params[:password])
        redirect_to(:new_session)
      else
        render(:edit)
      end
    else
      render(:edit)
    end
  end

  def password_params
    params.require(:password_form).permit(:email, :password, :password_confirmation)
  end
end
