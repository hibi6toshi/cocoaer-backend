class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :articles, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :forums, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :actions, dependent: :destroy

  def self.from_token_payload(payload)
    find_by(sub: payload['sub'])
  end

  def self.create_user_with_payload(payload)
    return if find_by(sub: payload['sub'])

    create!(sub: payload['sub'])
  end
end
