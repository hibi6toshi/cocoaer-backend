class Forum < ApplicationRecord
  include Favoritable
  include Commentable

  belongs_to :user
  belongs_to :piety_category
  belongs_to :piety_target

  validates :title, presence: true
  validates :title, length: { maximum: 30 }
  validates :body, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :days, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true


  def self.ransackable_attributes(auth_object = nil)
    %w[body cost created_at days id piety_category_id piety_target_id title updated_at user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[commented_by_users comments favorited_by_users favorites piety_category piety_target user]
  end
end
