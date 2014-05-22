class Sound < ActiveRecord::Base
  belongs_to :user 

  geocoded_by :city_country, :latitude => :latitude, :longitude => :longitude
  #after_validation :geocode, if: :name_changed?

  mount_uploader :echo, EchoUploader

  def city_country
    user.city + ',' + user.country
  end


end
