class User < ApplicationRecord
  ########## RATACHEMENT ENTRE LES TABLES ##########
  # has_many :messages, dependent: :destroy
  has_many :directors, dependent: :destroy
  has_many :organizations, through: :directors
  has_many :participations, dependent: :destroy
  has_many :events, through: :participations
  has_many :participating_events, through: :participations, source: :event
  ##################################################

  ############ VALIDATION ############
  has_one_attached :avatar
  validates :nickname, presence: true, format: { without: /\s/ }
  ####################################

  ########## VÉRIFICATION ##########
  def director?
    directors.exists?(user: self)
  end
  ##################################

  ############# DEVISE #############
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  ##################################
end
