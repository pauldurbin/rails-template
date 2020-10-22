class Organisation < ApplicationRecord
  has_many :organisation_users
  has_many :users, through: :organisation_users

  validates :name, presence: true
end
