class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :articles, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :forums, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_articles, through: :favorites, source: :favoritable, source_type: 'Article'
  has_many :favorited_projects, through: :favorites, source: :favoritable, source_type: 'Project'
  has_many :favorited_forums, through: :favorites, source: :favoritable, source_type: 'Forum'

  validates :name, presence: true

  def self.from_token_payload(payload)
    find_by(sub: payload['sub'])
  end

  def self.create_user_with_payload(payload, name)
    return if find_by(sub: payload['sub'])

    create!(sub: payload['sub'], name:)
  end

  def favorite(favoritable)
    favorite = favorites.new(favoritable:)
    favorite.save!
  end

  def unfavorite(favoritable)
    favorite = favorites.find_by(favoritable:)
    favorite.destroy
  end
end
