module SessionsHelper
  
  def sign_in(user)
    remember_token = Session.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    Session.create(remember_token: Session.encrypt(remember_token), user_id: user.id)
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
    remember_token = Session.encrypt(cookies[:remember_token])
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
  end

  def current_session
    remember_token = Session.encrypt(cookies[:remember_token])
    @current_session = Session.find_by(remember_token: remember_token)
  end

  def current_user
    if current_session
      @current_user = current_session.user
    else
      @current_user = nil
    end
  end
end

