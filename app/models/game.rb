class Game < ApplicationRecord

  has_many :belongings, dependent: :destroy
  has_many :tournaments, through: :belongings

  has_many :participatings, dependent: :destroy

  has_many :matches, dependent: :destroy

end
