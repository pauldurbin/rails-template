class Page < ApplicationRecord
  include Metadatable

  belongs_to :site
  has_many :shelves
  has_many :content_items, through: :shelves

  validates :menu_title, :slug, presence: true
  validates_format_of :ancestry, with: Ancestry::ANCESTRY_PATTERN, allow_nil: true

  has_ancestry ancestry_column: :ancestry, cache_depth: true

  before_validation do
    self.ancestry = nil if self.ancestry.blank?
  end

  scope :in_order, -> { order(:pos) }
  scope :for_header, -> { where(show_in_header: true) }
  scope :for_footer, -> { where(show_in_footer: true) }
end
