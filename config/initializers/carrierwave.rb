require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# 画像名に日本語が使えるようにする
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

# 保存先の分岐
CarrierWave.configure do |config|
  # 本番環境はS3に保存
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = ENV['S3_BUCKET_NAME'] # バケット名
    config.fog_public = false
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_ACCESS_KEY_ID'], # アクセスキー
      aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'], # シークレットアクセスキー
      region: 'ap-northeast-1', # リージョン
      path_style: true
    }
  else
    # 開発環境はlocalに保存
    config.storage :file
    config.asset_host = "http://localhost:3010"
    config.enable_processing = false if Rails.env.test? #test:処理をスキップ
  end
end
