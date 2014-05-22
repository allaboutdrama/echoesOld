CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJSMKK266UY2AEOWQ',                        # required
    :aws_secret_access_key  => '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',                        # required
#    :region                 => 'us-west-2',                  # optional, defaults to 'us-east-1'
    }
  config.fog_directory  = 'echoes'                     # required
  # config.fog_public     = true                                   # optional, defaults to true
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end