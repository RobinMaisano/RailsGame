class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable , :omniauthable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :participatings, dependent: :destroy
  has_many :tournaments, through: :participatings

  has_many :matches, :class_name => 'Match', :foreign_key => 'player1_id'
  has_many :matches, :class_name => 'Match', :foreign_key => 'player2_id'

  before_save :default_role

  validates_uniqueness_of :name

  def self.from_facebook(auth)

    where(facebook_id: auth.uid).or(where(email: auth.info.email)).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
    end
  end

end

 def default_role
   self.role ||= "user" # Ensure role is set on "user"
 end