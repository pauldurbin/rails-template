class Sortable
  def initialize(klass_name, ids)
    @klass_name = klass_name
    @ids = ids
  end

  def sort!
    return false if klass.nil?
    !objects_in_new_order.map(&:save).include?(false)
  end

  attr_accessor :klass_name, :ids
  
  private

  def objects_in_new_order
    [].tap do |objects|
      ids.each_with_index do |id, index|
        begin
          klass.find(id).tap do |obj|
            obj.position = (index + 1) * 100
            objects << obj
          end
        rescue
          next
        end
      end
    end
  end

  def klass
    return nil if klass_name.blank?
    klass_name.to_s.underscore.downcase.classify.constantize
  end
end
