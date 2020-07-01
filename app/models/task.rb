# frozen_string_literal: true

# :nodoc:
class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :description, length: { maximum: 500 }
  state_machine initial: :new_task do
    state :new_task
    state :in_development do
      validates :assignee, presence: true
    end
    state :in_qa
    state :in_code_review
    state :ready_for_release
    state :released
    state :archived

    event :assign do
      transition new_task: :in_development
    end
    event :develop do
      transition in_development: :in_qa
    end
    event :return_to_develop do
      transition [:in_qa, :in_code_review] => :in_development
    end
    event :qa_pass do
      transition in_qa: :in_code_review
    end
    event :code_review_pass do
      transition in_code_review: :ready_for_release
    end
    event :release do
      transition ready_for_release: :released
    end
    event :archive do
      transition [:new_task, :released] => :archived
    end
  end
end
