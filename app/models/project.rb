class Project < ApplicationRecord
  include Favoritable
  # include Commentable

  belongs_to :user
  belongs_to :piety_category
  belongs_to :piety_target

  has_many :tasks, dependent: :destroy
  has_many :actions, dependent: :destroy
end
