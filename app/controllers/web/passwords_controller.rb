class Web::PasswordsController < Web::ApplicationController
  include ResetPasswordHelper

  def new
    @password = PasswordForm.new
  end

  def create
    user = User.find_by(email: password_params[:email])

    if user.present?
      generate_password_token!(user)
      UserMailer.with(user_id: user.id, url: root_url).reset_password.deliver_now
      redirect_to(:new_session)
    else
      render(json: { error: ['Email address not found. Please check and try again.'] }, status: :not_found)
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
        render(json: { error: user.errors.full_messages }, status: :unprocessable_entity)
      end
    else
      render(:edit)
    end
  end

  def password_params
    params.require(:password_form).permit(:email, :password, :password_confirmation)
  end
end
