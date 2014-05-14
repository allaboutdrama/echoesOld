class Sound < ActiveRecord::Base
  belongs_to :user 

  geocoded_by :ip_address, :latitude => :latitude, :longitude => :longitude
#  after_validation :geocode #, if: :name_changed?

end
