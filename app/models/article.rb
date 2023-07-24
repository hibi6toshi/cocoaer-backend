class Article < ApplicationRecord
  include Favoritable

  mount_uploader :picture, ImageUploader

  belongs_to :user
  belongs_to :piety_category
  belongs_to :piety_target
end
