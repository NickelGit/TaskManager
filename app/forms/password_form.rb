class PasswordForm
  include ActiveModel::Model

  attr_accessor(
    :email,
    :password,
    :password_confirmation,
  )

  validates :email, presence: true, format: { with: /\A\S+@.+\.\S+\z/ }
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
end
