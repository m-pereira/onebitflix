class Serie < ApplicationRecord
  include Highlightable
  include PgSearch::Model
  multisearchable against: [:title]

  belongs_to :category
  belongs_to :last_watched_episode, class_name: 'Movie', optional: true

  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :episodes, -> { order(:episode_number) }, class_name: 'Movie', dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :thumbnail_key, presence: true
end
