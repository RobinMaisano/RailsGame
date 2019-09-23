class Tournament < ApplicationRecord

  geocoded_by :concat_address

  has_many :belongings, dependent: :destroy
  has_many :games, through: :belongings

  has_many :participatings, dependent: :destroy
  has_many :users, through: :participatings

  has_many :matches, dependent: :destroy

  after_validation :geocode

  def concat_address
    [address, city, country].compact.join(',')
  end

end
