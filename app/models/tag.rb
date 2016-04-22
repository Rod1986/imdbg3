class Tag < ActiveRecord::Base

  has_many :movie_tags
  has_many :movies, through: :movie_tags

  validates :name, uniqueness: true

end
