require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'create_task' do
    task = create(:task)
    assert task.persisted?
  end
end
