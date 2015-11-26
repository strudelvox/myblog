class StaticFaceController < ApplicationController

  def index
    session[:return_to]=""
    session.delete(:return_to)
  end

end
