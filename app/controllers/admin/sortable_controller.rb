class Admin::SortableController < Admin::AuthController
  # PATCH
  # Expecting:
  # :- Class name
  # :- Site id
  # :- Array of ids in order
  #
  # Sortable
  # (klass_name, ids_in_order)
  def sort
    Sortable.new(klass_name, ids_in_order).sort!
    head(:ok)
  end

  private

  def klass_name
    permitted_params.fetch(:klass)
  end

  def ids_in_order
    permitted_params.fetch(:ids)
  end

  def permitted_params
    params.permit!
  end
end
