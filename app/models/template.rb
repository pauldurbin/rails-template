class Template < ApplicationRecord
  include Metadatable

  belongs_to :site
  has_many :shelves

  validates :name, :filename, presence: true

  def template_path
    return "layouts/templates/#{filename}" if File.exists? full_path
    "layouts/templates/default"
  end

  def columns
    metadata.fetch("columns", 1).to_i
  end

  private

  def full_path
    File.join(Rails.root, "app", "views", "layouts/templates/_#{filename}.html.erb")
  end
end
