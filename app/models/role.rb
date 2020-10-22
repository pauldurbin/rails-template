class Role < ApplicationRecord
  belongs_to :site

  validates :name, presence: true, uniqueness: { scope: :site_id }
end
