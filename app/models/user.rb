class User < ActiveRecord::Base

  before_save :default_role
  after_create :send_welcome_email

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


    def send_welcome_email
      UserMailer.welcome_email(self).deliver_later
    end
end
