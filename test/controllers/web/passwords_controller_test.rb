require 'test_helper'

class Web::PasswordsControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should post create' do
    user = create(:user)
    attrs = { email: user.email }
    assert_emails 1 do
      post :create, params: { password_form: attrs }
    end
    assert_response :redirect
  end

  test 'should get edit' do
    user = create(:user)
    get :edit, params: { id: user.id }
    assert_response :success
  end

  test 'should patch update' do
    user = create(:user)
    attrs = { email: user.email }
    post :create, params: { password_form: attrs }
    token = User.find(user.id).reset_password_token
    reset_attrs = { password: 'password1', password_confirmation: 'password1' }
    post :update, params: { id: token, password_form: reset_attrs }
    assert_response :redirect
  end
end
