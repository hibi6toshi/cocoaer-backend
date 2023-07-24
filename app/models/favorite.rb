class Favorite < ApplicationRecord
  FAVORITABLE_TYPES = %w[Article Project Forum].map(&:freeze).freeze

  belongs_to :favoritable, polymorphic: true
  belongs_to :user

  validates :user_id, uniqueness: {
    scope: [:favoritable_id, :favoritable_type]
  }
end
