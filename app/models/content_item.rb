class ContentItem < ApplicationRecord
  include Metadatable

  has_one_attached :background_image
  has_one_attached :foreground_image

  belongs_to :shelf

  validates :name, presence: true
  before_create :set_position

  default_scope { order(position: :asc) }

  def html_content
    # @html_content ||= Kramdown::Document.new(content).to_html.html_safe
    content.html_safe
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

  def remove_foreground_image?
    remove_foreground_image.present? && remove_foreground_image == '1'
  end

  attr_accessor :remove_background_image, :remove_foreground_image

  private

  def set_position
    self.position = (shelf.content_items.count + 1) * 100 if position.blank?
  end
end
