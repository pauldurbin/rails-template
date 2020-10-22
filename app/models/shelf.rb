class Shelf < ApplicationRecord
  include Metadatable

  has_one_attached :background_image

  belongs_to :page
  belongs_to :template

  has_many :content_items

  validates :name, :template, presence: true
  before_create :set_position

  default_scope { order(position: :asc) }

  delegate :columns, to: :template
  delegate :template_path, to: :template

  def to_partial_path
    template_path
  end

  def background_crop
    @background_crop ||= JSON.parse(background_image_crop)
                             .with_indifferent_access
  rescue
    nil
  end

  def remove_background_image?
    remove_background_image.present? && remove_background_image == '1'
  end

  attr_accessor :remove_background_image

  private

  def set_position
    self.position = (page.shelves.count + 1) * 100 if position.blank?
  end
end
