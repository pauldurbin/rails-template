module ApplicationHelper
  def render_sortable(items, opts = {})
    render partial: 'admin/sortable/sortable', locals: { items: items, options: opts }
  end

  def is_current_page?(page, slug)
    page.slug == slug
  end

  def url_for_page(page)
    return '/ ' if page.slug == 'home'
    page.override_url.blank? ? "/#{page.slug}" : page.override_url
  end

  def image_url_for(blob, options = {})
    return '' unless blob.attachment.present?

    quality = options.fetch(:quality, 90).to_i

    "https://efcsa.imgix.net/#{blob.key}?auto=compress&#{generate_options(options.except(:quality))}" +
    (quality.blank? ? '' : "&quality=#{quality}")
  end

  def generate_options(options = {})
    [].tap do |ret|
      options.each do |k, v|
        ret << "#{k}=#{v}"
      end
    end.join('&')
  end

  def render_row_classes(element)
    [].tap do |ret|
      ret << 'row'
      ret << element.css_class unless element.css_class.blank?
      ret << 'background-image cover' if element.background_image.attachment.present?
    end.join(' ')
  end

  def render_item_classes(element)
    [].tap do |ret|
      ret << element.css_class unless element.css_class.blank?
      ret << 'background-image cover' if element.background_image.attachment.present?
    end.join(' ')
  end

  def render_inline_bg_for(element, options = {})
    return '' unless element.background_image.attachment.present?

    "background-image: url('#{image_url_for(element.background_image, image_crop(element, 'background_crop', h: 600))}')"
  end

  def render_inline_for(object, element, options = {})
    return '' unless object.send(element).attachment.present?

    "background-image: url('#{image_url_for(object.send(element))}')"
  end

  def thumbnail_crop(resource, opts = {})
    image_crop(resource, 'thumbnail_crop', opts)
  end

  def main_crop(resource, opts = {})
    image_crop(resource, 'main_crop', opts)
  end

  def image_crop(resource, method, opts = {})
    return opts.merge({ fit: 'crop', crop: 'edges' }) if resource.send(method).blank?
    opts.merge({
      rect: generate_rect(resource.send(method))
    })
  end

  def generate_rect(raw_crop)
    "#{raw_crop[:x]},#{raw_crop[:y]},#{raw_crop[:width]},#{raw_crop[:height]}"
  end
end
