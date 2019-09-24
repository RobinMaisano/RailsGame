class Match < ApplicationRecord

  belongs_to :player1, :class_name => "User"
  belongs_to :player2, :class_name => "User"
  belongs_to :tournament
  belongs_to :game

  scope :not_generated, -> {where(winner: nil)}

end