module SearchHelper
  def serialize_collection(collection)
    collection = [collection].flatten

    collection.map do |record|
      serializer_class = "#{record.class.name}Serializer".safe_constantize

      serializer_class.new(record).to_h
    end
  end
end
