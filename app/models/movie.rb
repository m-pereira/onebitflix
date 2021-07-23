class Movie < ApplicationRecord
  include Highlightable
  include PgSearch::Model
  multisearchable against: %i[title description], if: ->(record) { record.serie.nil? }

  belongs_to :serie, optional: true
  belongs_to :category, optional: true

  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :players, dependent: :destroy
  has_one :watched_serie, class_name: 'Serie', foreign_key: 'last_watched_episode_id',
    dependent: :nullify

  validates :title, presence: true
  validates :description, presence: true
  validates :thumbnail_key, presence: true
  validates :video_key, presence: true
  validates :episode_number, presence: true, uniqueness: { scope: :serie },
    if: -> { serie.present? }
  validates :category, presence: true, if: -> { serie.nil? }

  validate :highlight_episode

  private

  def highlight_episode
    return unless serie
    return unless highlighted

    errors.add(:base, 'It\'s not possible to highlight serie episode')
  end
end
