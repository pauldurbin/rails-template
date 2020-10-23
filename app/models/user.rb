class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :recoverable, :rememberable, :validatable, :trackable

  has_many :site_users
  has_many :sites, through: :site_users

  has_many :organisation_users
  has_many :organisations, through: :organisation_users

  has_many :role_users
  has_many :roles, through: :role_users

  def deity?
    role_names.include? 'deity'
  end

  def role_list
    role_names.join(', ')
  end

  private

  def role_names
    roles.map(&:name)
  end
end
