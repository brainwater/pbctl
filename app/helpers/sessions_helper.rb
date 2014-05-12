module SessionsHelper
  
  def sign_in(user)
    remember_token = Session.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    puts remember_token
    puts Session.encrypt(remember_token)
    Session.create(remember_token: Session.encrypt(remember_token), user_id: user.id)
    #user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def authenticated?
    !current_user.nil? || User.count == 0
  end

  def authenticated_redirect
    redirect_to signin_url, notice: "Please sign in." unless authenticated?
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user=(user)
    remember_token = Session.encrypt(cookies[:remember_token])
    current_session ||= Session.find_by(remember_token: remember_token)
    if current_session
      @current_user ||= current_session.user
    end
#    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user
    remember_token = Session.encrypt(cookies[:remember_token])
    current_session ||= Session.find_by(remember_token: remember_token)
    if current_session
      @current_user ||= current_session.user
    end
  end
end

