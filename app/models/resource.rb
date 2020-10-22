class Resource < ApplicationRecord
  belongs_to :site
  has_many :resource_products
  has_many :products, through: :resource_products

  validates :title, presence: true

  has_one_attached :file

  default_scope { with_attached_file }
end
