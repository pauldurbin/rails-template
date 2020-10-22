class Paginator
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  def initialize(results = [], params = {})
    @results = results
    @params = params
  end

  def render
    content_tag(:ul,
      previous_link.html_safe + pages.html_safe + next_link.html_safe,
      class: 'pagination'
    )
  end

  def previous_link
    return '' if current_page == 1
    generate_link('Previous', current_page - 1)
  end

  def pages
    page_count.times.map do |i|
      generate_link(i+1, i+1)
    end.join
  end

  def next_link
    return '' if current_page == page_count
    generate_link('Next', current_page + 1)
  end

  attr_accessor :results, :params
  private

  def generate_link(title, page_number)
    content_tag(:li,
      link_to(
        title,
        url_for(params.merge(page: page_number).merge(link_params)),
        remote: remote?, class: 'page-link'
      ),
      class: 'page-item ' + ((page_number == current_page) ? 'active' : '')
    )
  end

  def page_count
    @page_count ||= results.count
  end

  def current_page
    @current_page ||= params.fetch(:page, 1).to_i
  end

  def per_page
    @per_page ||= params.fetch(:per_page, nil)
  end

  def remote?
    @remote ||= params.fetch(:remote, false)
  end

  def target
    @target ||= params.fetch(:target, nil)
  end

  def query
    @query ||= params.fetch(:query, nil)
  end

  def site_id
    @site_id ||= params.fetch(:site_id, nil)
  end

  def link_params
    { per_page: per_page, target: target, query: query, site_id: site_id }.compact
  end
end
