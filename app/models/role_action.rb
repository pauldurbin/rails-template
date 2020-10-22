class RoleAction < ApplicationRecord
  belongs_to :role

  validates :role_id, presence: true
end
