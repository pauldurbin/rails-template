module Metadatable
  extend ActiveSupport::Concern

  attr_accessor :metadata_raw

  def metadata_raw
    self.metadata
  end

  def metadata_raw=(meta)
    self.metadata = if meta.blank?
      {}
    else
      eval(meta)
    end
  end
end
