CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     Rails.application.credentials[Rails.env.to_sym][:aws_key],                        # required unless using use_iam_profile
    aws_secret_access_key: Rails.application.credentials[Rails.env.to_sym][:aws_password],                        # required unless using use_iam_profile
    region:                'us-west-2',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = Rails.application.credentials[Rails.env.to_sym][:aws_bucket]                                      # required
end
