class User < ActiveRecord::Base
  has_many :sounds

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  geocoded_by :city 
  after_validation :geocode

end
