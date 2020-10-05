CarrierWave.configure do |config|

  config.fog_credentials = {
    provider:              'AWS',                            # required
    aws_access_key_id:     ENV["AWS_ACCESS_KEY"],            # required
    aws_secret_access_key: ENV["AWS_SECRET_KEY"],            # required
    region:                'us-east-1'
  }
  config.fog_directory = ENV["AWS_BUCKET"]                   # required
  config.fog_public    = false
  config.cache_dir.    = "#{Rails.root}/tmp/uploads"         # To let CarrierWave work on heroku

  # store files locally in test and development environments
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

end