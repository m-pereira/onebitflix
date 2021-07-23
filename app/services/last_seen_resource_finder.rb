class LastSeenResourceFinder
  include SearchHelper

  def self.call(*args)
    new(*args).call
  end

  def initialize(type, user)
    @type = type
    @user = user
  end

  def call
    send("group_by_#{type}")
  end

  private

  attr_reader :type, :user

  def group_by_category
    categories = Category.includes(:movies, :series)

    serialize_collection(categories)
  end

  def group_by_keep_watching
    players = Player.includes(:movie, :user).where(end_date: nil, user: user)

    serialize_collection(players)
  end

  def group_by_highlight
    highlight = Movie.find_by(highlighted: true)
    highlight ||= Serie.find_by(highlighted: true)

    serialize_collection(highlight)
  end
end
