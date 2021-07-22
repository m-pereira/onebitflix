class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :elapsed_time

  belongs_to :user
  belongs_to :movie
end
