class PlayerSerializer < ActiveModel::Serializer
  attributes :id

  attribute(:start_date) { I18n.l(object.start_date) if object.start_date }
  attribute(:elapsed_time) { object.elapsed_time&.strftime('%H:%M:%S') }
  attribute(:end_date) { I18n.l(object.end_date) if object.end_date }

  belongs_to :movie
end
