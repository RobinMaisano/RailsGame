class Tournament < ApplicationRecord

  has_many :belongings, dependent: :destroy
  has_many :games, through: :belongings

  has_many :participatings, dependent: :destroy
  has_many :users, through: :participatings

end
