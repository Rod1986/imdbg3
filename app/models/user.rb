class User < ActiveRecord::Base

  before_save :default_role

  has_many :movies

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :lastname, :username, presence: true
  validates :username, uniqueness: {case_sensitive: false}

  enum role: [:admin, :editor, :guest, :other]

  def to_s
    "#{self.name} #{self.lastname}"
  end

  private

    def default_role
      self.role ||= 2
    end
end
