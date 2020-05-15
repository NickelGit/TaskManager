require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    admin = create(:admin)
    sign_in admin
  end

  test 'should get show' do
    user = create(:user)
    get :show, params: { id: user.id }
    assert_response :success
  end
  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get edit' do
    user = create(:user)
    get :edit, params: { id: user.id }
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should post create' do
    user = attributes_for(:user)
    assert_not User.find_by(email: user[:email]).present?

    post :create, params: { user: user }
    created_user = User.find_by(email: user[:email])

    assert created_user.present?
    assert created_user[:first_name] == user[:first_name]
    assert created_user[:last_name] == user[:last_name]
    assert created_user.authenticate(user[:password])
    assert created_user[:type] == user[:type]
  end

  test 'should patch update' do
    user = create(:user)
    user_attrs = attributes_for(:developer)

    patch :update, params: { id: user.id, user: user_attrs }
    patched_user = User.find(user.id)

    assert patched_user[:first_name] == user_attrs[:first_name]
    assert patched_user[:last_name] == user_attrs[:last_name]
    assert patched_user.authenticate(user_attrs[:password])
    assert patched_user[:type] == user_attrs[:type]

    new_user_attrs = attributes_for(:manager)
    patch :update, params: { id: user.id, user: new_user_attrs }
    patched_user = User.find(user.id)

    assert patched_user[:first_name] == new_user_attrs[:first_name]
    assert patched_user[:last_name] == new_user_attrs[:last_name]
    assert patched_user.authenticate(new_user_attrs[:password])
    assert patched_user[:type] == new_user_attrs[:type]
  end

  test 'should delete destroy' do
    user = create(:user)
    delete :destroy, params: { id: user.id }
    assert_not User.find_by(id: user.id).present?
  end
end
