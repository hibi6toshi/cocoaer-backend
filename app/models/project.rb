class Project < ApplicationRecord
  include Favoritable
  # include Commentable

  belongs_to :user
  belongs_to :piety_category
  belongs_to :piety_target

  has_many :tasks, dependent: :destroy
  has_many :actions, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { maximum: 30 }
  validates :body, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true

  def self.ransackable_attributes(auth_object = nil)
    %w[body cost created_at id limit_day piety_category_id piety_target_id title updated_at user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[actions favorited_by_users favorites piety_category piety_target tasks user]
  end
end
