class Site < ApplicationRecord
  include Metadatable

  has_many :pages,              dependent: :destroy
  has_many :templates,          dependent: :destroy
  has_many :resources,          dependent: :destroy
  has_many :roles,              dependent: :destroy

  has_many :site_users
  has_many :users, through: :site_users

  validates :name, :urn, presence: true, uniqueness: { case_sensitive: false }

  before_validation :generate_urn, on: :create
  after_create_commit :generate_roles

  private

  def generate_urn
    return '' if name.blank?
    self.urn = name.parameterize
  end

  def generate_roles
    ['deity', 'admin', 'content', 'user'].each do |r|
      self.roles.create(name: r, active: true)
    end
  end
end
