require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'create_developer' do
    developer = create(:developer)
    assert developer.persisted?
  end

  test 'create_admin' do
    admin = create(:admin)
    assert admin.persisted?
  end

  test 'create_manager' do
    manager = create(:manager)
    assert manager.persisted?
  end
end
