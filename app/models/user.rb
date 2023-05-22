class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :forums, dependent: :destroy

  def self.from_token_payload(payload)
    find_by(sub: payload['sub']) || create!(sub: payload['sub'])
    # TODO: 初期認証の対応
  end
end
