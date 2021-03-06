# frozen_string_literal: true

# :nodoc:
class User < ApplicationRecord
  has_secure_password
  has_many :my_tasks, class_name: 'Task', foreign_key: :author_id
  has_many :assigned_tasks, class_name: 'Task', foreign_key: :assignee_id
  validates :first_name, presence: true
  validates :first_name, length: { minimum: 2 }
  validates :last_name, presence: true
  validates :last_name, length: { minimum: 2 }
  validates :email, presence: true
  validates :email, format: { with: /\A\S+@.+\.\S+\z/ }
  validates :email, uniqueness: true
  validates :reset_password_token, uniqueness: { allow_blank: true }
end
