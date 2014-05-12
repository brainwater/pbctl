class Session < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :remember_token, presence: true, length: { is: 128 }
#  before_create :create_remember_token

  def Session.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Session.encrypt(token)
    Digest::SHA512.hexdigest(token.to_s)
  end

  def user
    return User.find_by(id: self.user_id)
  end

  private
  
  def create_remember_token
    self.remember_token = Session.encrypt(Session.new_remember_token)
  end
end
