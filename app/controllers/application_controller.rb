class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  before_action :require_login
  #before_action :require_auto_login
 


  private
 
  def require_login
    redirect_to "/login" unless is_authenticated 
  end


  def require_auto_login
    
    if ( !is_authenticated)

        login_results = LoginService.login ({ :username => "admin", :password => "admin"})
        session[:JSESSIONID] = login_results[:jsessionid]
        puts login_results
    end

  end

  def is_authenticated
      LoginService.is_authenticated( session[:JSESSIONID])
  end

end
