module PaginationHelper
  def custom_paginate(results, params)
    Paginator.new(results, params.permit!).render
  end
end
