class Forum < ApplicationRecord
  belongs_to :user
  belongs_to :piety_category
  belongs_to :piety_target
end
