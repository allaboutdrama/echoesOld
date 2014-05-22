class Sound < ActiveRecord::Base
  belongs_to :user 

  geocoded_by :ip_address, :latitude => :latitude, :longitude => :longitude
  after_validation :geocode, if: :name_changed?

# def upload_sound
#     establish_connection_to_s3
#     self.url = "https://s3-us-west-2.amazonaws.com/allaboutdrama/sounds/xxxxx"
#   end

#   def establish_connection_to_s3
#     @s3 = AWS::S3.new(
#       access_key_id:     S3_CREDENTIALS["access_key_id"],
#       secret_access_key: S3_CREDENTIALS["secret_access_key"],
#       region: "us-west-2"
#     )

#     @bucket = @s3.buckets[S3_CREDENTIALS["bucket"]]
#   end






end
