class Forum < ApplicationRecord
  include Favoritable
  
  belongs_to :user
  belongs_to :piety_category
  belongs_to :piety_target
end
