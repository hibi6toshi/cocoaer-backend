module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable
    has_many :commented_by_users, through: :comments, source: :user
  end
end