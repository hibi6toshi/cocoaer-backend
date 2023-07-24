module Favoritable
  extend ActiveSupport::Concern

  included do
    has_many :favorites, as: :favoritable
    has_many :favorited_by_users, through: :favorites, source: :user
  end
end