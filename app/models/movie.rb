class Movie < ActiveRecord::Base

  mount_uploader :photo, PhotoUploader

  validate :max_tags
  validates :name, presence: true

  has_many :movie_tags
  has_many :tags, through: :movie_tags

  belongs_to :user


  private

  def max_tags
    if self.tags.count > 3
      errors.add :tags, 'no puede ser tan muchos'
    end
  end
end
