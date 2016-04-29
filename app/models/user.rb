class User < ActiveRecord::Base
  before_save :default_role
  after_create :send_welcome_email

  has_many :movies

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]

  validates :name, :lastname, :username, presence: true
  validates :username, uniqueness: {case_sensitive: false}

  enum role: [:admin, :editor, :guest, :other]

  def to_s
    "#{self.name} #{self.lastname}"
  end

  private

    def self.find_for_facebook_oauth(auth)

      user = User.where(provider: auth.provider, uid: auth.uid).first
      # The User was found in our database
      return user if user

      # Check if the User is already registered without Facebook
      user = User.where(email: auth.info.email).first
      return user if user

      User.create(
        name: auth.extra.raw_info.first_name,
        lastname: auth.extra.raw_info.last_name,
        username: "#{auth.extra.raw_info.first_name}_#{auth.extra.raw_info.last_name}",
        avatar: auth.info.image,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )

    end

    def default_role
      self.role ||= 2
    end


    def send_welcome_email
      UserMailer.welcome_email(self).deliver_later
    end
end
