class Tournament < ApplicationRecord

  has_many :belongings, dependent: :destroy
  has_many :games, through: :belongings

end
