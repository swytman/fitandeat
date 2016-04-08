class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and

  #TEMP_EMAIL_PREFIX = 'change@me'
  #TEMP_EMAIL_REGEX = /\Achange@me/
  #has_one :identity

  devise :database_authenticatable, :registerable, :confirmable, :validatable,
         :recoverable, :rememberable, :trackable, :omniauthable

  #validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  #validates :name, uniqueness: true

  has_and_belongs_to_many :groups

  def admin?
    groups.find_by(key: 'administrators').present?
  end

  #def provider_profile
  #  identity.provider_profile if identity.present?
  #end
  #
  #def provider
  #  identity.provider if identity.present?
  #end
  #
  #def self.find_for_oauth(auth, signed_in_resource = nil)
  #
  #  # Получить identity пользователя, если он уже существует
  #
  #  identity = Identity.find_for_oauth(auth)
  #  identity.set_current
  #  # Если signed_in_resource предоставлен оно всегда переписывает существующего пользователя
  #  # что бы identity не была закрыта случайно созданным аккаунтом.
  #  # Заметьте, что это может оставить зомби-аккаунты (без прикрепленной identity)
  #  # которые позже могут быть удалены
  #  user = signed_in_resource ? signed_in_resource : identity.user
  #
  #  # Создать пользователя, если нужно
  #  if user.nil?
  #
  #    # Получить email пользователя, если его предоставляет провайдер
  #    # Если email не был предоставлен мы даем пользователю временный и просим
  #    # пользователя установить и подтвердить новый в следующим шаге через UsersController.finish_signup
  #    email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
  #    email = auth.info.email if email_is_verified
  #    user = User.where(:email => email).first if email
  #    # Создать пользователя, если это новая запись
  #    if user.nil?
  #      user = User.new(
  #          name: auth.info.name,
  #          #username: auth.info.nickname || auth.uid,
  #          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
  #          password: Devise.friendly_token[0,20]
  #      )
  #      user.skip_confirmation!
  #      user.save!
  #      if auth.info.image.present? || auth.info.name.present?
  #        identity.photourl = auth.info.image
  #        identity.username = auth.info.name
  #        identity.provider_profile = auth.info.urls.Vkontakte if identity.provider == "vkontakte"
  #        identity.provider_profile = "http://facebook.com/#{auth.extra.raw_info.id}" if identity.provider == "facebook"
  #        identity.save!
  #      end
  #
  #
  #    end
  #  end
  #
  #  # Связать identity с пользователем, если необходимо
  #  if identity.user != user
  #    identity.user = user
  #    identity.save!
  #  end
  #  user
  #end
  #
  #def email_verified?
  #  self.email && self.email !~ TEMP_EMAIL_REGEX
  #end

end
